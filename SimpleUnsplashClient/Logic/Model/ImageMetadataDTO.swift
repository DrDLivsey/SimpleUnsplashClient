//
//  APIAnswer.swift
//  SimpleUnsplashClient2
//
//  Created by Sergey Nikiforov on 06.07.2023.
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
