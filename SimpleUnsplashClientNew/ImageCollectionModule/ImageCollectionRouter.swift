//
//  ImageCollectionRouter.swift
//  SimpleUnsplashClientNew
//
//  Created by Sergey Nikiforov on 09.08.2023.
//

import UIKit

protocol ImageCollectionRouterInput: AnyObject {
    func openImage(imgID: String, userName: String)
}

final class ImageCollectionRouter {
    weak var view: UIViewController?
}

extension ImageCollectionRouter: ImageCollectionRouterInput {
    func openImage(imgID: String, userName: String) {
        let imageDetailVC = ImageDetailBuilder().make(imgID: imgID)
        view?.navigationController?.pushViewController(imageDetailVC, animated: true)
        imageDetailVC.navigationItem.title = userName
    }
}
