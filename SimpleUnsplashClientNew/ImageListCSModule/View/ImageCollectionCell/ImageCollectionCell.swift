//
//  ImageCollectionCell.swift
//  SimpleUnsplashClientNew
//
//  Created by Sergey Nikiforov on 09.08.2023.
//

import UIKit
import Kingfisher

// класс для отображения
final class ImageCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var imageThumb: UIImageView?
    @IBOutlet weak var imageDescription: UILabel?
    @IBOutlet weak var imageLikes: UILabel?
    
    // метод конфигурирования ячейки для списка
    func configure(model: ImageCollectionCellModel) {
        imageThumb?.kf.setImage(with: model.imageURLThumb)
        imageDescription?.attributedText = model.imageDescription
        imageLikes?.text = "Likes: \(model.imageLikes)"
    }
    
}
