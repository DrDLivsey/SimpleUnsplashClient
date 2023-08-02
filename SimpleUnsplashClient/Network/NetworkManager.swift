//
//  NetworkCaller.swift
//  SimpleUnsplashClient2
//
//  Created by Sergey Nikiforov on 06.07.2023.
//

import Foundation

protocol NetworkManagerProtocol {
    func getData(currentPage: Int, urlWithPage: String, completion: @escaping (Result<[ImageAPIAnswer], Error>) -> ())
}

final class NetworkManager: NetworkManagerProtocol {
    
    enum Error: Swift.Error {
           case wrongURL
           case wrongResponse
           case decodingError
       }
       
       private enum Constants {
           static let domain = "https://api.unsplash.com/"
       }
    
    func getData(currentPage: Int, urlWithPage: String, completion: @escaping (Result<[ImageAPIAnswer], Error>) -> ()) {
        
        guard let url = URL(string: urlWithPage) else {
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
                let result = try JSONDecoder().decode([ImageAPIAnswer].self, from: data!)
                completion(.success(result))
                
            } catch {
                completion(.failure(Error.decodingError))
            }
        }
        task.resume()
    }
}
