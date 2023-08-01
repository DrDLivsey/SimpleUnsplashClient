//
//  ApiClient.swift
//  SimpleUnsplashClient
//
//  Created by Sergey Nikiforov on 31.07.2023.
//

import Foundation

protocol APIClientProtocol {
    func getImages(currentPage: Int, completion: @escaping (Result<Data, APIClient.Error>) -> ())
}


final class APIClient: APIClientProtocol {
    
    indirect enum Error: Swift.Error {
        case wrongURL(String)
        case wrongResponse(URLResponse?)
        case brokenJSON(URLResponse, Error)
    }
    
    func getImages(currentPage: Int, completion: @escaping (Result<Data, Error>) -> ()) {
        
        guard let url = createURL(page: currentPage) else {
            completion(.failure(Error.wrongURL("Couldn't create URL for request data")))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(Error.wrongResponse(response)))
                return
            }
            
            guard data != nil else {
                completion(.failure(Error.brokenJSON(response, error as! APIClient.Error)))
                return
            }
            
            completion(.success(data!))
        }
        task.resume()
    }
}

extension APIClient {
    
    private enum Constants {
        static let scheme = "https"
        static let domain = "api.unsplash.com"
        static let endpoint = "/photos/"
        static let clientID = "client_id"
        static let page = "page"
    }
    
    private func createURL(page: Int) -> URL? {
        var components = URLComponents()
        components.scheme = Constants.scheme
        components.host = Constants.domain
        components.path = Constants.endpoint
        components.queryItems = [
            URLQueryItem(name: Constants.clientID,
                         value: Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String),
            URLQueryItem(name: Constants.page,
                         value: String(page))
        ]
        if let url = components.url {
            return url
        } else {
            return nil
        }
    }
}

