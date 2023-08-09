//
//  ImageListLocalDataSource.swift
//  SimpleUnsplashClientNew
//
//  Created by Sergey Nikiforov on 09.08.2023.
//

import Foundation

protocol ImageListLocalDataSourceProtocol {
    func getImageItems (currentPage: Int) -> [ImageMetadata]?
    func setImageItems (currentPage: Int, imageItems: [ImageMetadata])
}

final class ImageListLocalDataSource: ImageListLocalDataSourceProtocol {
    
    private let cache = NSCache<NSString, ImageStorageWrapper>()
    
    func getImageItems (currentPage: Int) -> [ImageMetadata]? {
        let nsCurrentPage = NSString(string: String(currentPage))
        if let cachedData = cache.object(forKey: nsCurrentPage) {
            let imageItems = cachedData.wrapper
            return imageItems
        } else {
            return nil
        }
    }
    
    func setImageItems (currentPage: Int, imageItems: [ImageMetadata]) {
        let nsCurrentPage = NSString(string: String(currentPage))
        self.cache.setObject(ImageStorageWrapper(wrapper: imageItems), forKey: nsCurrentPage)
    }
    
    //класс-обертка, куда помещается коллекция экземпляров
    //ImageMetadata для корректной работы с NSCache(принимает только классы)
    //ImageMetadata - структура
    private class ImageStorageWrapper {
        
        let wrapper: [ImageMetadata]
        
        init(wrapper: [ImageMetadata]) {
            self.wrapper = wrapper
        }
    }
}
