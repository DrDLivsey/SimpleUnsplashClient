//
//  ImageDetailBuilder.swift
//  SimpleUnsplashClientNew
//
//  Created by Sergey Nikiforov on 09.08.2023.
//

import UIKit

protocol ImageDetailBuilderProtocol {
    func make(imgID: String) -> UIViewController
}

final class ImageDetailBuilder: ImageDetailBuilderProtocol {
    
    func make(imgID: String) -> UIViewController {
        
        let presenter = ImageDetailPresenter()
        let interactor = ImageDetailInteractor(
            presenter: presenter,
            imageListRepository: ImageListRepository.sharedInstance,
            imgID: imgID
        )
        
        
        let imageDetailVC = ImageDetailVC(interactor: interactor)
        
        presenter.view = imageDetailVC
        
        return imageDetailVC
    }
}
