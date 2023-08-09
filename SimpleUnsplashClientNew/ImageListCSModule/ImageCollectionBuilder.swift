//
//  ImageCollectionBuilder.swift
//  SimpleUnsplashClientNew
//
//  Created by Sergey Nikiforov on 09.08.2023.
//

import UIKit

protocol ImageCollectionBuilderProtocol: AnyObject {
    func make() -> UIViewController
}

final class ImageCollectionBuilder {
    
    func make() -> UIViewController {
        let presenter = ImageCollectionPresenter()
        let router = ImageCollectionRouter()
        let interactor = ImageCollectionInteractor(presenter: presenter,
                                                   router: router,
                                                   imageListRepository: ImageListRepository())
        
        let vc = ImageCollectionVC(intercator: interactor)
        
        presenter.view = vc
        router.view = vc
        
        return vc
    }
}
