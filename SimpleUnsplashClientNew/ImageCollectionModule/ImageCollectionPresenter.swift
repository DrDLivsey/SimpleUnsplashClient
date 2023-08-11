//
//  ImageCollectionPresenter.swift
//  SimpleUnsplashClientNew
//
//  Created by Sergey Nikiforov on 09.08.2023.
//

import UIKit
import Kingfisher

protocol ImageCollectionPresenterInput {
    func showLoading()
    func showLoadingError(_ error: Error)
    func show(imageCollection: [ImageMetadata])
}

final class ImageCollectionPresenter {
    
    weak var view: ImageCollectionVCInput?
    
}

extension ImageCollectionPresenter: ImageCollectionPresenterInput {
    
    func showLoading() {
        view?.configure(state: .loading)
    }
    
    func showLoadingError(_ error: Error) {
        view?.configure(state: .loadingError(error))
    }
    
    func show(imageCollection: [ImageMetadata]) {
        let imagesItems = imageCollection.map { metadata -> ImageCollectionCellModel in
            let cellModel = ImageCollectionCellModel(
                imageID: metadata.id,
                imageURLThumb: metadata.imageThumb,
                imageDescription: NSAttributedString(
                    string: "\(metadata.description)",
                    attributes: [NSAttributedString.Key.foregroundColor: UIColor(hex: metadata.color)]
                ),
                imageLikes: String(metadata.likes)
            )
            return cellModel
        }
        view?.configure(state: .content(imagesItems))
    }
}
