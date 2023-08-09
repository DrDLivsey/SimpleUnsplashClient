//
//  ImageCollectionInteractor.swift
//  SimpleUnsplashClientNew
//
//  Created by Sergey Nikiforov on 09.08.2023.
//

import Foundation

protocol ImageCollectionInteractorInput: AnyObject {
    func viewDidLoad()
    
    func didTapRetryLoading()
    func didTapImage(imgID: String)
}

final class ImageCollectionInteractor {
    
    private enum ImageCollectionInteractorError: Error {
        case retryError
        case noRetryError
    }
    
    private let presenter: ImageCollectionPresenterInput
    private let router: ImageCollectionRouter
    
    private let imageListRepository: ImageListRepositoryProtocol
    
    init(presenter: ImageCollectionPresenterInput, router: ImageCollectionRouter, imageListRepository: ImageListRepositoryProtocol) {
        self.presenter = presenter
        self.router = router
        
        self.imageListRepository = imageListRepository
    }
    
    private func loadImages() {
        imageListRepository.getImageItems(currentPage: 1) { [weak self] result in
            DispatchQueue.main.async {
                self?.handleImageItemsResult(result)
            }
        }
    }
    
    private func handleImageItemsResult(_ result: Result<[ImageMetadata], ImageListRepository.ImageListRepositoryError>) {
        switch result {
        case .success(let imagesInternalModel):
            presenter.show(imageCollection: imagesInternalModel)
        
        case .failure(let error):
            var errorType = convertImageListRepositoryErrorToImageCollectionInteractorError(error)
            switch errorType {
//MARK: СДЕЛАТЬ ОТОБРАЖЕНИЕ ДВУХ РАЗНЫХ ЭКРАНОВ, ОДИН С ВОЗМОЖНОСТЬЮ ОБНОВИТЬ ДАННЫЕ, ДРУГОЙ - БЕЗ
            case .retryError:
                presenter.showLoadingError(error)
            
            case .noRetryError:
                presenter.showLoadingError(error)
            }
        }
    }
}


extension ImageCollectionInteractor: ImageCollectionInteractorInput {
    
    func viewDidLoad() {
        presenter.showLoading()
        loadImages()
    }
    
    func didTapRetryLoading() {
        presenter.showLoading()
        loadImages()
    }
    
    func didTapImage(imgID: String) {
        router.openImage(imgID: imgID)
    }
}

extension ImageCollectionInteractor {
    private func convertImageListRepositoryErrorToImageCollectionInteractorError(_ input: ImageListRepository.ImageListRepositoryError) -> ImageCollectionInteractor.ImageCollectionInteractorError {
        
        var output: ImageCollectionInteractor.ImageCollectionInteractorError
        
        switch input {
        case .internalError:
            output = ImageCollectionInteractorError.retryError
        case .requestError:
            output = ImageCollectionInteractorError.noRetryError
        }
        return output
    }
}
