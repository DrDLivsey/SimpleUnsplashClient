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
    }
    
    func configureForRetryError(_ error: Error) -> UIAlertController {
        return UIAlertController(
            title: "Возникла ошибка",
            message: "При работе возника ошибка - \(error). Попробовать еще раз?",
            preferredStyle: .alert
        )
    }
}
