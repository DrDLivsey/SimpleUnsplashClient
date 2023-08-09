//
//  ImageListRemoteDataSource.swift
//  SimpleUnsplashClientNew
//
//  Created by Sergey Nikiforov on 09.08.2023.
//

import Foundation

protocol ImageListRemoteDataSourceProtocol {
    func getDTOModels (currentPage: Int,
                       completion: @escaping (Result<[ImageMetadataDTO], ImageListRemoteDataSource.ImageListRemoteDataSourceError>) -> ())
}

final class ImageListRemoteDataSource: ImageListRemoteDataSourceProtocol {
    
    enum ImageListRemoteDataSourceError: Error {
        case internalError
        case networkError
    }
    
    private enum Constants {
        static let endpoint = "photos"
    }
    
    private let apiClient: APIClientProtocol = APIClient()
    
    func getDTOModels (currentPage: Int,
                       completion: @escaping (Result<[ImageMetadataDTO], ImageListRemoteDataSource.ImageListRemoteDataSourceError>) -> ())
    {
        
        let parameters = ["page":String(currentPage)]
        
        apiClient.requestData(ofType:[ImageMetadataDTO].self ,path: Constants.endpoint, parameters: parameters) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let dtoModels):
                completion(.success(dtoModels))
                
            case .failure(let error):
                completion(.failure(self.convertAPIClientToDataSourceError(input: error)))
            }
        }
    }
}


private extension ImageListRemoteDataSource {
    
    private func convertAPIClientToDataSourceError(input: APIClient.APIClientError) -> ImageListRemoteDataSource.ImageListRemoteDataSourceError {
        var output: ImageListRemoteDataSource.ImageListRemoteDataSourceError
        switch input {
        case .wrongURL:
            output = ImageListRemoteDataSourceError.internalError
        case .requestError:
            output = ImageListRemoteDataSourceError.networkError
        case.decodingError:
            output = ImageListRemoteDataSourceError.internalError
        }
        return output
    }
}
