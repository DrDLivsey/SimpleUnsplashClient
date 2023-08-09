//
//  Alert.swift
//  SimpleUnsplashClientNew
//
//  Created by Sergey Nikiforov on 09.08.2023.
//

import UIKit

final class Alert: UIAlertController {
    
    func configureForNoRetryError(_ error: Error) -> UIAlertController {
        return UIAlertController(
            title: "Возникла ошибка",
            message: "При работе возникла серьезная ошибка - \(error)",
            preferredStyle: .alert
        )
        
        self.addAction(UIAlertAction(
            title: "Понятно",
            style: .cancel)
        )
    }
    
    func configureForRetryError(_ error: Error) -> UIAlertController {
        return UIAlertController(
            title: "Возникла ошибка",
            message: "При работе возника ошибка - \(error). Попробовать еще раз?",
            preferredStyle: .alert
        )
        
        self.addAction(UIAlertAction(
            title: "Да",
            style: .default,
            handler: {return}
        )
        
        self.addAction(UIAlertAction(
            title: "Нет",
            style: .cancel)
        )
    }
}
