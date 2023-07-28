//
//  ImageItemsCache.swift
//  SimpleUnsplashClient2
//
//  Created by Sergey Nikiforov on 06.07.2023.
//

import Foundation

protocol CacheManagerProtocol {
    func getImageItems (currentPage: Int) -> [ImageDisplayModel]?
    func putImageItems (currentPage: Int, imageItems: [ImageDisplayModel]) -> ()
}

final class CacheManager: CacheManagerProtocol {
    
    private let cache = NSCache<NSString, ImageStorageWrapper>()
    
    func getImageItems (currentPage: Int) -> [ImageDisplayModel]? {
        let nsCurrentPage = NSString(string: String(currentPage))
        if let cachedData = cache.object(forKey: nsCurrentPage) {
            let imageItems = cachedData.wrapper
            return imageItems
        } else {
            return nil
        }
    }
    
    func putImageItems (currentPage: Int, imageItems: [ImageDisplayModel]) -> () {
        let nsCurrentPage = NSString(string: String(currentPage))
        self.cache.setObject(ImageStorageWrapper(wrapper: imageItems), forKey: nsCurrentPage)
    }
    
    //класс-обертка, куда помещается коллекция экземпляров
    //ImageAPIModel для корректной работы с NSCache(принимает только классы)
    //ImageAPIModel - структура
    private class ImageStorageWrapper {
        
        let wrapper: [ImageDisplayModel]
        
        init(wrapper: [ImageDisplayModel]) {
            self.wrapper = wrapper
        }
    }
}





