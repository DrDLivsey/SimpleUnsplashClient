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

extension ImageMetadataDTO {
    var domainModel: ImageMetadata? {
        guard let urls = urls else {
            return nil
        }
        
        return ImageMetadata(description: description ?? altDescription ?? "No description",
                             color: color ?? "No color",
                             likes: likes ?? 0,
                             imageThumb: urls.thumb,
                             imageRegular: urls.regular,
                             user: user?.username ?? "No username")
    }
}
