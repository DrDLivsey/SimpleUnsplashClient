//
//  APIAnswer.swift
//  SimpleUnsplashClient2
//
//  Created by Sergey Nikiforov on 06.07.2023.
//

import Foundation

struct APIAnswer: Decodable {
    let color: String?
    let description: String?
    let alt_description: String?
    let urls: Urls?
    let likes: Int?
    let user: User?
}

struct Urls: Decodable {
    let thumb: String?
    let regular: String?
}

struct User: Decodable {
    let username: String?
}
