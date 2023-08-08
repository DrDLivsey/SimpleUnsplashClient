//
//  ImageCollectionInteractor.swift
//  SimpleUnsplashClient
//
//  Created by Sergey Nikiforov on 02.08.2023.
//

import Foundation

//исправить название, сделать более точным
protocol ImageCollectionInteractorInput {
    func fetchImages()
}

final class ImageCollectionInteractor {
    
    //сначала все публичное
    //потом все приватное
    
    //типы
    //проперти
    //иниты
    //методы
    
    private let presenter: ImageCollectionPresenterInput?
    //добавить сильную ссылку на роутер var router: RouterInput?
    
    
    //надо делать опциональным, а не пустым! переделано
    private var imageCollection: [ImageMetadata]?
    
    private let imageListRepository = ImageListRepository()
    
    //добавить init
   
   
}

//fetch дб приватным
//снаружи должны приходить факты а не указания

extension ImageCollectionInteractor: ImageCollectionInteractorInput {
    func fetchImages() {
        //исправить входной параметр для функции
        imageListRepository.getImageItems(currentPage: 1)
        
        let imageCollection = imageListRepository.imagesInternalModel
        presenter?.present(imageCollection: imageCollection)
    }
}
