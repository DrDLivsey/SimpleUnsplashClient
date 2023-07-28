//
//  NetworkCaller.swift
//  SimpleUnsplashClient2
//
//  Created by Sergey Nikiforov on 06.07.2023.
//

import Foundation

protocol NetworkManagerProtocol {
    func getImagesFromAPI(currentPage: Int, completion: @escaping (Result<[ImageAPIModel], Error>) -> ())
}

final class NetworkManager: NetworkManagerProtocol {
    
    enum Error: Swift.Error {
        case wrongURL
        case wrongResponse
        case decodingError
    }
    
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
            URLQueryItem(name: Constants.page, value: String(page))
        ]
        if let url = components.url {
            return url
        } else {
            return nil
        }
    }
    
    func getImagesFromAPI(currentPage: Int, completion: @escaping (Result<[ImageAPIModel], Error>) -> ()) {
        
        guard let url = createURL(page: currentPage) else {
            completion(.failure(Error.wrongURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(Error.wrongResponse))
                return
            }
            
            guard data != nil else {
                return
            }
            do {
                let result = try JSONDecoder().decode([ImageAPIModel].self, from: data!)
                completion(.success(result))
                
            } catch {
                completion(.failure(Error.decodingError))
            }
        }
        task.resume()
    }
}