//
//  ImageCollectionInteractor.swift
//  SimpleUnsplashClientNew
//
//  Created by Sergey Nikiforov on 09.08.2023.
//

import Foundation

protocol ImageCollectionInteractorInput: AnyObject {
    func viewDidLoad()
    func loadImages()
}

final class ImageCollectionInteractor {
    
    private let presenter: ImageCollectionPresenterInput
    private let router: ImageCollectionRouter
    private let imageListRepository: ImageListRepositoryProtocol
    
    init(presenter: ImageCollectionPresenterInput, router: ImageCollectionRouter, imageListRepository: ImageListRepositoryProtocol) {
        self.presenter = presenter
        self.router = router
        self.imageListRepository = imageListRepository
    }
    
    private func handleImageItemsResult(_ result: Result<[ImageMetadata], ImageListRepository.ImageListRepositoryError>) {
        switch result {
        case .success:
            imageListRepository.imagesInternalModel
            //используем обновленное хранилище в imageListRepository
        case. failure(let error):
            //обработать ошибку
        }
    }
    
    
    extension ImageCollectionInteractor: ImageCollectionInteractorInput {
        
        func viewDidLoad() {
            presenter.showLoading()
            loadImages()
        }
        
        func loadImages() {
            imageListRepository.getImageItems(currentPage: 1) { [weak self] result in
                DispatchQueue.main.async {
                    self?.handleImageItemsResult(result)
                }
            }
        }
    }
    
