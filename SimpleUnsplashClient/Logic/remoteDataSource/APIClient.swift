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
    func requestData(path: String, parameters: [String:String], completion: @escaping (Result<Data, APIClient.APIClientError>) -> ())
}


final class APIClient: APIClientProtocol {
    
    enum APIClientError: Error {
        case wrongURL(String)
        case requestError(String)
    }
    
    private enum Constants {
        static let scheme = "https"
        static let domain = "api.unsplash.com"
    }
    
    private let enviromentProvider: EnvironmentProviderProtocol = EnvironmentProvider()
    
    func requestData(path: String, parameters: [String:String], completion: @escaping (Result<Data, APIClient.APIClientError>) -> ()) {
        
        var parameters = parameters
        parameters["client_id"] = enviromentProvider.getAPIKeyValue()
        
        guard let url = createURL(path: path, parameters: parameters) else {
            print("URL created for URLSession is broken")
            completion(.failure(APIClientError.wrongURL("Couldn't create URL with requested data")))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard data != nil else {
                print("No data after URLSession has worked")
                completion(.failure(APIClientError.requestError("No data from server")))
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
