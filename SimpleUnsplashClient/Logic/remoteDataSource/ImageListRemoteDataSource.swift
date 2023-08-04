//
//  NetworkCaller.swift
//  SimpleUnsplashClient2
//
//  Created by Sergey Nikiforov on 06.07.2023.
//

import Foundation

protocol ImageListRemoteDataSourceProtocol {
    func getDTOModels (path: String, currentPage: Int, completion: @escaping (Result<[ImageMetadataDTO]?, Error>) -> ())
}

final class ImageListRemoteDataSource: ImageListRemoteDataSourceProtocol {
    
    private let apiClient: APIClientProtocol = APIClient()
    
    func getDTOModels (path: String, currentPage: Int, completion: @escaping (Result<[ImageMetadataDTO]?, Error>) -> ()) {
        
        apiClient.requestData(path: path, currentPage: currentPage) { result in
            switch result {
            case .success(let response):
                let resultedDTOModels = self.convertJSONToDTO(imageDataFromAPI: response)
                completion(.success(resultedDTOModels))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

extension ImageListRemoteDataSource {
    private func convertJSONToDTO (imageDataFromAPI: Data) -> [ImageMetadataDTO]? {
        do {
            let result = try JSONDecoder().decode([ImageMetadataDTO].self, from: imageDataFromAPI)
            return result
        } catch {
            return nil
        }
    }
}
