//
//  ImageDetailRouter.swift
//  SimpleUnsplashClientNew
//
//  Created by Sergey Nikiforov on 09.08.2023.
//

import UIKit

protocol ImageDetailRouterInput: AnyObject {
    
    func openLobby()
    
}

final class ImageDetailRouter {
    
    weak var view: UIViewController?
    
}

extension ImageDetailRouter: ImageDetailRouterInput {
    
    func openLobby() {}
}
