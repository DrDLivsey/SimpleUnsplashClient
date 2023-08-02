//
//  ImageCollectionPresenter.swift
//  SimpleUnsplashClient
//
//  Created by Sergey Nikiforov on 02.08.2023.
//

import UIKit
import Kingfisher

protocol PresenterInput {
    func present(imageCollection: [ImageMetadata])
}

final class ImageCollectionPresenter {
    
    weak var viewController: ViewInput?

}

extension ImageCollectionPresenter: PresenterInput {
    func present(imageCollection: [ImageMetadata]){
        let imagesForDisplay = imageCollection.map { metadata -> ImageCollectionCellModel in
            let cellModel = ImageCollectionCellModel(imageFile: UIImageView.kf.setImage(with: .network(URL(string: metadata.imageThumb)),
                                                     imageDescription: NSAttributedString(string: "\(metadata.description)",
                                                                                          attributes: [NSAttributedString.Key.foregroundColor : UIColor(hex: metadata.color)]),
                                                     imageLikes: String(metadata.likes))
        }
        
//        viewController?.display(imagesForDisplay)
    }
}


