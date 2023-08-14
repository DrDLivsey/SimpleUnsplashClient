//
//  ImageDetailInteractor.swift
//  SimpleUnsplashClientNew
//
//  Created by Sergey Nikiforov on 09.08.2023.
//

import Foundation

protocol ImageDetailInteractorInput: AnyObject {
    func viewDidLoad()
}

final class ImageDetailInteractor {
    
    private let presenter: ImageDetailPresenterInput

    private let imagesRepository: ImagesRepositoryProtocol
    
    private let imgID: String
    
    init(
        presenter: ImageDetailPresenterInput,
        imagesRepository: ImagesRepositoryProtocol,
        imgID: String
    ) {
        self.presenter = presenter
        self.imagesRepository = imagesRepository
        self.imgID = imgID
    }
    
    private func loadImage() {
        imagesRepository.getImageItem(imgID: imgID) { [weak self] result in
            DispatchQueue.main.async {
                self?.handleImageResult(result)
            }
        }
    }
    
    private func handleImageResult(_ result: Result<ImageMetadata, ImagesRepository.ImagesRepositoryError>) {
        guard case let .success(image) = result else {
            return
        }
        presenter.showImage(image: image)
        
    }
}

extension ImageDetailInteractor: ImageDetailInteractorInput {
    
    func viewDidLoad() {
        loadImage()
    }
}
