//
//  NetworkCaller.swift
//  SimpleUnsplashClient2
//
//  Created by Sergey Nikiforov on 06.07.2023.
//
//класс, как дб видно из названия, который знает точное называние ручки
//в которую надо стучаться, чтобы получить файл с данными для списка фото

import Foundation

protocol ImageListRemoteDataSourceProtocol {
    func getDTOModels (currentPage: Int, completion: @escaping (Result<[ImageMetadataDTO]?, ImageListRemoteDataSource.ImageListRemoteDataSourceError>) ->())
    
}

final class ImageListRemoteDataSource: ImageListRemoteDataSourceProtocol {
    
    enum ImageListRemoteDataSourceError: Error {
        case internalError(String)
        case externalError(String)
    }
    
    private enum Constants {
        static let endpoint = "photos"
    }
    
    private let apiClient: APIClientProtocol = APIClient()
    
    func getDTOModels (currentPage: Int,completion: @escaping (Result<[ImageMetadataDTO]?, ImageListRemoteDataSource.ImageListRemoteDataSourceError>) ->()) {
        
        var parameters = ["page":String(currentPage)]
        
        apiClient.requestData(path: Constants.endpoint, parameters: parameters) { result in
            switch result {
            case .success(let response):
                guard let resultedDTOModels = self.convertJSONToDTO(imageDataFromAPI: response) else {
                    print("Couldn't convert from JSON to DTOModels")
                    completion(.failure(ImageListRemoteDataSourceError.internalError("Couldn't convert from JSON to DTOModels")))
                    return
                }
                completion(.success(resultedDTOModels))
                
            case .failure(let error):
                completion(.failure(self.apiClientToDataSourceError(input: error)))
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
    
    private func apiClientToDataSourceError(input: APIClient.APIClientError) -> ImageListRemoteDataSource.ImageListRemoteDataSourceError {
        var output: ImageListRemoteDataSource.ImageListRemoteDataSourceError
        switch input {
        case .requestError(let message):
            output = ImageListRemoteDataSourceError.externalError(message)
        case .wrongURL(let message):
            output = ImageListRemoteDataSourceError.internalError(message)
        }
        return output
    }
}
