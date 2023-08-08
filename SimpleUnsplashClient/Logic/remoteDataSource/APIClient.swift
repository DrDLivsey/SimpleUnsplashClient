//
//  ApiClient.swift
//  SimpleUnsplashClient
//
//  Created by Sergey Nikiforov on 31.07.2023.
//
//класс реализует доступ к API unsplash по любой ручке
//параметры, которой мы передадим

import Foundation

protocol APIClientProtocol {
    func requestData<DTO:Decodable>(ofType type:DTO.Type,
                                    path: String,
                                    parameters: [String:String],
                                    completion: @escaping (Result<DTO, APIClient.APIClientError>) -> ())
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
    
    func requestData<DTO:Decodable>(ofType type:DTO.Type,
                                    path: String,
                                    parameters: [String:String],
                                    completion: @escaping (Result<DTO, APIClient.APIClientError>) -> ())
    {
        
        var parameters = parameters
        parameters["client_id"] = enviromentProvider.getAPIKeyValue()
        
        guard let url = createURL(path: path, parameters: parameters) else {
            print("URL created for URLSession is broken")
            completion(.failure(APIClientError.wrongURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data else {
                print("No data after URLSession has worked")
                completion(.failure(APIClientError.requestError))
                return
            }
            
            do {
                let result = try self.decoder.decode(DTO.self, from: data)
                print("Model(s) was created. This is the result: \(result)")
                completion(.success(result))
            } catch let error {
                print("Something went wrong during decoding process JSON-DTO")
                completion(.failure(APIClientError.decodingError(error)))
            }
            
        }
        task.resume()
    }
}



private extension APIClient {
    
    private func createURL(path: String, parameters: [String:String]) -> URL? {
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
