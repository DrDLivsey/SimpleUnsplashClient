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
    func present(imageCollection: [ImageMetadata])
}

final class ImageCollectionPresenter {
    
    weak var view: ImageCollectionVCInput?

}

extension ImageCollectionPresenter: ImageCollectionPresenterInput {
    
    func showLoading() {
        view?.configure(state: .loading)
    }

    func present(imageCollection: [ImageMetadata]){
        let imagesForDisplay = imageCollection.map { metadata -> ImageCollectionCellModel in
            let cellModel = ImageCollectionCellModel(imageURL: metadata.imageThumb,
                                                     imageDescription: NSAttributedString(string: "\(metadata.description)",
                                                                                          attributes: [NSAttributedString.Key.foregroundColor : UIColor(hex: metadata.color)]),
                                                     imageLikes: String(metadata.likes))
            return cellModel
        }
        
//        viewController?.display(imagesForDisplay)
    }
}
