//
//  ImageItemsCache.swift
//  SimpleUnsplashClient2
//
//  Created by Sergey Nikiforov on 06.07.2023.
//

import Foundation

protocol ImageItemsCacheProtocol {
    func getImageItems (currentPage: Int) -> [ImageItem]?
    func putImageItems (currentPage: Int, imageItems: [ImageItem]) -> ()
}

class ImageItemsCache: ImageItemsCacheProtocol {
    
    private let cache = NSCache<NSString, ImageStorageWrapper>()
    
    func getImageItems (currentPage: Int) -> [ImageItem]? {
        
        let nsCurrentPage = NSString(string: String(currentPage))
        
        if let cachedData = cache.object(forKey: nsCurrentPage) {
            let imageItems = cachedData.wrapper
            return imageItems
        } else {
            return nil
        }
    }
    
    func putImageItems (currentPage: Int, imageItems: [ImageItem]) -> () {
        
        let nsCurrentPage = NSString(string: String(currentPage))
        self.cache.setObject(ImageStorageWrapper(wrapper: imageItems), forKey: nsCurrentPage)
    }
    
    //класс-обертка, куда помещается коллекция экземпляров
    //ImageAPIAnswer для корректной работы с NSCache(принимает только классы)
    //ImageAPIAnswer - структура
    private class ImageStorageWrapper {
    
        let wrapper: [ImageItem]
        
        init(wrapper: [ImageItem]) {
            self.wrapper = wrapper
        }
    }
}





