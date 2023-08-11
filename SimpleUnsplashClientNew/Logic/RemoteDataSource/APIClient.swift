//
//  APIClient.swift
//  SimpleUnsplashClientNew
//
//  Created by Sergey Nikiforov on 09.08.2023.
//

import Foundation

protocol APIClientProtocol {
    func requestData<DTO: Decodable>(
        ofType type: DTO.Type,
        path: String,
        parameters: [String: String],
        completion: @escaping (Result<DTO, APIClient.APIClientError>) -> Void
    )
}


final class APIClient: APIClientProtocol {
    enum APIClientError: Error {
        case wrongURL
        case requestError
        case decodingError(Error)
    }
    
    private enum Constants {
        static let scheme = "https"
        static let domain = "api.unsplash.com"
    }
    
    private let enviromentProvider: EnvironmentProviderProtocol = EnvironmentProvider()
    private var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    func requestData<DTO: Decodable>(
        ofType type: DTO.Type,
        path: String,
        parameters: [String: String],
        completion: @escaping (Result<DTO, APIClient.APIClientError>) -> Void
    ) {
        var parameters = parameters
        parameters["client_id"] = enviromentProvider.getAPIKeyValue()
        
        guard let url = createURL(path: path, parameters: parameters) else {
            completion(.failure(APIClientError.wrongURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(APIClientError.requestError))
                return
            }
            
            do {
                let result = try self.decoder.decode(DTO.self, from: data)
                completion(.success(result))
            } catch let error {
                completion(.failure(APIClientError.decodingError(error)))
            }
        }
        task.resume()
    }
}

private extension APIClient {
    private func createURL(path: String, parameters: [String: String]) -> URL? {
        var components = URLComponents()
        components.scheme = Constants.scheme
        components.host = Constants.domain
        components.path = path
        components.queryItems = parameters.map {
            URLQueryItem(name: $0.0, value: $0.1)
        }
        return components.url
    }
}
