//
//  ApiClient.swift
//  SimpleUnsplashClient
//
//  Created by Sergey Nikiforov on 31.07.2023.
//

import Foundation

protocol APIClientProtocol {
    func requestData(path: String, currentPage: Int, completion: @escaping (Result<Data, Error>) -> ())
}


final class APIClient: APIClientProtocol {
    
    private enum APIClientError: Error {
        case wrongURL(String)
        case requestError(Error?)
    }
    
    private enum Constants {
        static let scheme = "https"
        static let domain = "api.unsplash.com"
    }
    
    private let enviromentProvider: EnvironmentProviderProtocol = EnvironmentProvider()
    
    func requestData(path: String, currentPage: Int, completion: @escaping (Result<Data, Error>) -> ()) {
        
        var parameters = ["page": String(currentPage)]
        parameters["client_id"] = enviromentProvider.extractWith(key: "API_KEY")
        
        guard let url = createURL(path: path, parameters: parameters) else {
            completion(.failure(APIClientError.wrongURL("Couldn't create URL with requested data")))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard data != nil else {
                completion(.failure(APIClientError.requestError(error)))
                return
            }
            
            completion(.success(data!))
        }
        task.resume()
    }
}



extension APIClient {
    
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
