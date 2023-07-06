//
//  ImageItem.swift
//  SimpleUnsplashClient2
//
//  Created by Sergey Nikiforov on 06.07.2023.
//

import UIKit

protocol ImageItemProtocol {
    var description: String { get }
    var color: String { get }
    var likes: Int { get }
    var imageThumb: UIImage { get }
    var imageRegular: UIImage { get }
    var user: String { get }
}

struct ImageItem: ImageItemProtocol {
    var description: String
    var color: String
    var likes: Int
    var imageThumb: UIImage
    var imageRegular: UIImage
    var user: String
}

