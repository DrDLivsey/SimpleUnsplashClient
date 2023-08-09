//
//  ImageMetadataDTO.swift
//  SimpleUnsplashClientNew
//
//  Created by Sergey Nikiforov on 09.08.2023.
//

import Foundation

struct ImageMetadataDTO: Decodable {
    let id: String?
    let color: String?
    let description: String?
    let altDescription: String?
    let urls: ImageUrlsDTO?
    let likes: Int?
    let user: ImageUserDTO?
}

struct ImageUrlsDTO: Decodable {
    let thumb: URL?
    let regular: URL?
}

struct ImageUserDTO: Decodable {
    let username: String?
}
