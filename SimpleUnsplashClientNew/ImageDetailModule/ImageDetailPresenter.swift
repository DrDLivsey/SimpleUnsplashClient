//
//  ImageDetailPresenter.swift
//  SimpleUnsplashClientNew
//
//  Created by Sergey Nikiforov on 09.08.2023.
//

import Foundation

protocol ImageDetailPresenterInput: AnyObject {
    func showImage(image: ImageMetadata)
}

final class ImageDetailPresenter {
    
    weak var view: ImageDetailViewInput?
    
}

extension ImageDetailPresenter: ImageDetailPresenterInput {
    
    func showImage(image: ImageMetadata) {
        let imageModel = ImageDetailModel(
            imageURLRegular: image.imageRegular,
            imageUser: image.user
        )
        view?.configure(imageModel: imageModel)
    }
}
