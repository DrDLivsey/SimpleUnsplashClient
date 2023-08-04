//
//  EnvironmentProvider.swift
//  SimpleUnsplashClient
//
//  Created by Sergey Nikiforov on 04.08.2023.
//

import Foundation


protocol EnvironmentProviderProtocol {
    func extractWith(key: String) -> String?
}

final class EnvironmentProvider: EnvironmentProviderProtocol {
    func extractWith(key: String) -> String? {
        return Bundle.main.object(forInfoDictionaryKey: key) as? String
    }
}
