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
    
    weak var view: ImageDetailVCInput?
    
}

extension ImageDetailPresenter: ImageDetailPresenterInput {
    
    func showImage(image: ImageMetadata) {
        let imageModel = ImageDetailModel(
            imageURLThumb: image.imageThumb,
            imageUser: image.user
        )
        view?.configure(imageModel: imageModel)
    }
}
