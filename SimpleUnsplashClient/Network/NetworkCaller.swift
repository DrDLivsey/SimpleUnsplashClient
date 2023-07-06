//
//  NetworkCaller.swift
//  SimpleUnsplashClient2
//
//  Created by Sergey Nikiforov on 06.07.2023.
//

import Foundation

protocol NetworkCallerDelegate: AnyObject {
    func getErrorCode(errorCode: Int) -> ()
}

protocol NetworkCallerProtocol {
    func getData(currentPage: Int, urlWithPage: String, completion: @escaping (Result<[APIAnswer], Error>) -> ())
}

class NetworkCaller: NetworkCallerProtocol {
    
    weak var delegate: NetworkCallerDelegate?
    
    func setViewDelegate(delegate: NetworkCallerDelegate) {
        self.delegate = delegate
    }
    
    func getData(currentPage: Int, urlWithPage: String, completion: @escaping (Result<[APIAnswer], Error>) -> ()) {
       
        guard let url = URL(string: urlWithPage) else {
            self.delegate?.getErrorCode(errorCode: 600)
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let response = response as? HTTPURLResponse else {
                self.delegate?.getErrorCode(errorCode: 700)
                return
            }
                self.delegate?.getErrorCode(errorCode: response.statusCode)
            
            guard data != nil else {
                return
            }
            do {
                let result = try JSONDecoder().decode([APIAnswer].self, from: data!)
                completion(.success(result))
                
            } catch {
                self.delegate?.getErrorCode(errorCode: 800)
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
