//
//  ImageCollectionInteractor.swift
//  SimpleUnsplashClient
//
//  Created by Sergey Nikiforov on 02.08.2023.
//

import Foundation

protocol InteractorInput {
    func fetchImages()
}

final class ImageCollectionInteractor {
    
    var presenter: PresenterInput?
    //добавить сильную ссылку на роутер var router: RouterInput?
    
    var imageCollection: [ImageMetadata] = []
    
   
}

extension ImageCollectionInteractor: InteractorInput {
    func fetchImages() {
        let imageListRepository = ImageListRepository()
        
        //исправить входной параметр для функции
        imageListRepository.getImageItems(currentPage: 1)
        
        let imageCollection = imageListRepository.imagesInternalModel
        presenter?.present(imageCollection: imageCollection)
    }
}
