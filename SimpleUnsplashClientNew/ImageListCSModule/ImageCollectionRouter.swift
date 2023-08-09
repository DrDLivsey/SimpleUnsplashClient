//
//  ImageCollectionRouter.swift
//  SimpleUnsplashClientNew
//
//  Created by Sergey Nikiforov on 09.08.2023.
//

import UIKit

protocol ImageCollectionRouterInput: AnyObject {
    func openImage(alias: String)
}

final class ImageCollectionRouter {
    
    weak var view: UIViewController?
}

extension ImageCollectionRouter: ImageCollectionRouterInput {
    func openGame(alias: String) {
        let imageDetailVC = ImageCollectionBuilder.make()(imageAlias: String)
        
        
    }
}
