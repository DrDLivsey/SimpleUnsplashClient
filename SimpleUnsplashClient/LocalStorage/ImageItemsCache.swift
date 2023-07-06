//
//  ImageItemsCache.swift
//  SimpleUnsplashClient2
//
//  Created by Sergey Nikiforov on 06.07.2023.
//

import Foundation

protocol ImageItemsCacheProtocol {
    func getImageItems (currentPage: Int) -> [ImageItemProtocol]?
    func putImageItems (currentPage: Int, imageItems: [ImageItemProtocol]) -> ()
}

class ImageItemsCache: ImageItemsCacheProtocol {
    
    private let cache = NSCache<NSString, ImageStorageWrapper>()
    
    func getImageItems (currentPage: Int) -> [ImageItemProtocol]? {
        
        let nsCurrentPage = NSString(string: String(currentPage))
        
        if let cachedData = cache.object(forKey: nsCurrentPage) {
            let imageItems = cachedData.wrapper
            return imageItems
        } else {
            return nil
        }
    }
    
    func putImageItems (currentPage: Int, imageItems: [ImageItemProtocol]) -> () {
        
        let nsCurrentPage = NSString(string: String(currentPage))
        self.cache.setObject(ImageStorageWrapper(wrapper: imageItems), forKey: nsCurrentPage)
    }
    
    //класс-обертка, куда помещается коллекция экземпляров
    //APIAnswer для корректной работы с NSCache(принимает только классы)
    //APIAnswer - структура
    private class ImageStorageWrapper {
    
        let wrapper: [ImageItemProtocol]
        
        init(wrapper: [ImageItemProtocol]) {
            self.wrapper = wrapper
        }
    }
}





