//
//  EnvironmentProvider.swift
//  SimpleUnsplashClient
//
//  Created by Sergey Nikiforov on 04.08.2023.
//
//класс, который вытаскивыает значения из info.plist
//на каждое значение свой метод

import Foundation


protocol EnvironmentProviderProtocol {
    func getAPIKeyValue() -> String?
}

final class EnvironmentProvider: EnvironmentProviderProtocol {
    func getAPIKeyValue() -> String? {
        let key = "API_KEY"
        return Bundle.main.object(forInfoDictionaryKey: key) as? String
    }
}

