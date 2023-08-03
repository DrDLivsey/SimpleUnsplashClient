//
//  APIAnswer.swift
//  SimpleUnsplashClient2
//
//  Created by Sergey Nikiforov on 06.07.2023.
//

import Foundation

struct ImageMetadataDTO: Decodable {
    let color: String?
    let description: String?
    let alt_description: String?
    let urls: ImageUrlsDTO?
    let likes: Int?
    let user: ImageUserDTO?
}

struct ImageUrlsDTO: Decodable {
    let thumb: String?
    let regular: String?
}

struct ImageUserDTO: Decodable {
    let username: String?
}