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

final class ImageCollectionBuilder: ImageCollectionBuilderProtocol {
    func make() -> UIViewController {
        let presenter = ImageCollectionPresenter()
        let router = ImageCollectionRouter()
        let interactor = ImageCollectionInteractor(
            presenter: presenter,
            router: router,
            imageListRepository: ImageListRepository.sharedInstance
        )
        
        let imageCollectionVC = ImageCollectionVC(intercator: interactor)

        presenter.view = imageCollectionVC
        router.view = imageCollectionVC

        return imageCollectionVC
    }
}
