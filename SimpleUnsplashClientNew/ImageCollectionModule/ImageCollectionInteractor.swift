//
//  ImageCollectionInteractor.swift
//  SimpleUnsplashClientNew
//
//  Created by Sergey Nikiforov on 09.08.2023.
//

import Foundation

protocol ImageCollectionInteractorInput: AnyObject {
    func viewDidLoad(currentPage: Int)
    
    func didTapRetryLoading()
    func didTapImage(imgID: String, userName: String)
}

final class ImageCollectionInteractor {
    
    private enum ImageCollectionInteractorError: Error {
        case retryError
        case noRetryError
    }
    
    private let presenter: ImageCollectionPresenterInput
    private let router: ImageCollectionRouter
    
    private let imagesRepository: ImagesRepositoryProtocol
    
    init(
        presenter: ImageCollectionPresenterInput,
        router: ImageCollectionRouter,
        imagesRepository: ImagesRepositoryProtocol
    ) {
        self.presenter = presenter
        self.router = router
        
        self.imagesRepository = imagesRepository
    }
    
    private func loadImages(currentPage: Int) {
        imagesRepository.getImageItems(currentPage: currentPage) { [weak self] result in
            DispatchQueue.main.async {
                self?.handleImageItemsResult(result)
            }
        }
    }
    
    private func handleImageItemsResult(_ result: Result<[ImageMetadata], ImagesRepository.ImagesRepositoryError>) {
        switch result {
        case .success(let imagesInternalModel):
            presenter.show(imageCollection: imagesInternalModel)

        case .failure(_):
            return
            // TODO: implement error
            // let errorType = convertImagesRepositoryErrorToImageCollectionInteractorError(error)
            // switch errorType {
            // case .retryError:
            // presenter.showLoadingError(error)
            // case .noRetryError:
            // presenter.showLoadingError(error)
            // }
        }
    }
}

extension ImageCollectionInteractor: ImageCollectionInteractorInput {
    
    func viewDidLoad(currentPage: Int) {
        presenter.showLoading()
        loadImages(currentPage: currentPage)
    }
    
    func didTapRetryLoading() {
        presenter.showLoading()
    }
    
    func didTapImage(imgID: String, userName: String) {
        router.openImage(imgID: imgID, userName: userName)
    }
}
