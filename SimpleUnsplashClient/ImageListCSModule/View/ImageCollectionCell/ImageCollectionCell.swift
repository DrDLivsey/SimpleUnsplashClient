//
//  ImageCollectionCell.swift
//  SimpleUnsplashClient2
//
//  Created by Sergey Nikiforov on 06.07.2023.
//

import UIKit

//ячейка для списка

//структура дата полей
struct ImageCollectionCellModel {
    let imageFile: UIImageView
    let imageDescription: NSAttributedString
    let imageLikes: String
}

//класс для отображения
final class ImageCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var imageThumb: UIImageView?
    @IBOutlet weak var imageDescription: UILabel?
    @IBOutlet weak var imageLikes: UILabel?
    
    //метод конфигурирования ячейки для списка
    private func configure(model: ImageCollectionCellModel) {
        imageThumb = model.imageFile
        imageDescription?.attributedText = model.imageDescription
        imageLikes?.text = model.imageLikes
    }
    
}

