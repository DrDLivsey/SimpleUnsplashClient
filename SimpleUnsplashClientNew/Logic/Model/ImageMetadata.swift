//
//  ImageMetadata.swift
//  SimpleUnsplashClientNew
//
//  Created by Sergey Nikiforov on 09.08.2023.
//

import Foundation

struct ImageMetadata {
    let id: String
    let color: String
    let description: String
    let imageThumb: URL?
    let imageRegular: URL?
    let likes: Int
    let user: String
}
