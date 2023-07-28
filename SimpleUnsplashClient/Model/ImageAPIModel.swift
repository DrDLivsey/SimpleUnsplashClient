//
//  APIAnswer.swift
//  SimpleUnsplashClient2
//
//  Created by Sergey Nikiforov on 06.07.2023.
//

import Foundation

struct ImageAPIModel: Decodable {
    let color: String?
    let description: String?
    let alt_description: String?
    let urls: ImageUrls?
    let likes: Int?
    let user: ImageUser?
}

struct ImageUrls: Decodable {
    let thumb: String?
    let regular: String?
}

struct ImageUser: Decodable {
    let username: String?
}
