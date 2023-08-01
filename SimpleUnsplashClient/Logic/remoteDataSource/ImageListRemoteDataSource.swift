//
//  NetworkCaller.swift
//  SimpleUnsplashClient2
//
//  Created by Sergey Nikiforov on 06.07.2023.
//

import Foundation

protocol ImageListRemoteDataSourceProtocol {
    func convertJSONToDTO (imageDataFromAPI: Data) -> [ImageMetadataDTO]?
}

final class ImageListRemoteDataSource: ImageListRemoteDataSourceProtocol {
    
    func convertJSONToDTO (imageDataFromAPI: Data) -> [ImageMetadataDTO]? {
        do {
            let result = try JSONDecoder().decode([ImageMetadataDTO].self, from: imageDataFromAPI)
            return result
        } catch {
            return nil
        }
    }
}
