//
//  ImageCollectionPresenter.swift
//  SimpleUnsplashClient
//
//  Created by Sergey Nikiforov on 02.08.2023.
//

import UIKit
import Kingfisher

protocol ImageCollectionPresenterInput {
    func present(imageCollection: [ImageMetadata])
}

final class ImageCollectionPresenter {
    
    weak var viewController: ImageCollectionVCInput?

}

extension ImageCollectionPresenter: ImageCollectionPresenterInput {
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


