//
//  ImageCollectionCell.swift
//  SimpleUnsplashClient2
//
//  Created by Sergey Nikiforov on 06.07.2023.
//

import UIKit
import Kingfisher

//ячейка для списка

//структура дата полей
//поле imageURL должно быть опциональным
//так как из api может не прийти ссылка
//а в imageListRepository при маппинге мы присваиваем NO URL string
//из нее нельзя сделать URL
struct ImageCollectionCellModel {
    let imageURL: URL?
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
//        imageThumb = model.imageURL
        imageDescription?.attributedText = model.imageDescription
        imageLikes?.text = model.imageLikes
        
    }
    
}

