//
//  EnvironmentProvider.swift
//  SimpleUnsplashClientNew
//
//  Created by Sergey Nikiforov on 09.08.2023.
//

import Foundation


protocol EnvironmentProviderProtocol {
    func getAPIKeyValue() -> String?
}

final class EnvironmentProvider: EnvironmentProviderProtocol {
    func getAPIKeyValue() -> String? {
        return Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String
    }
}
