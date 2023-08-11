//
//  ImageCollectionCell.swift
//  SimpleUnsplashClientNew
//
//  Created by Sergey Nikiforov on 09.08.2023.
//

import UIKit
import Kingfisher

final class ImageCollectionCell: UICollectionViewCell {
    
    @IBOutlet private weak var imageThumb: UIImageView?
    @IBOutlet private weak var imageDescription: UILabel?
    @IBOutlet private weak var imageLikes: UILabel?
    
    func configure(model: ImageCollectionCellModel) {
        imageThumb?.kf.setImage(with: model.imageURLThumb)
        imageDescription?.attributedText = model.imageDescription
        imageLikes?.text = "Likes: \(model.imageLikes)"
    }
    
}
