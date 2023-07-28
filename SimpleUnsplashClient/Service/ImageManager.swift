//
//  Presenter.swift
//  SimpleUnsplashClient2
//
//  Created by Sergey Nikiforov on 06.07.2023.
//

import UIKit

protocol ImageManagerProtocol {
    func prepareImageItems(currentPage: Int) -> ()
}

final class ImageManager: ImageManagerProtocol {
    
    private var imagesForDisplay: [ImageDisplayModel] = []
    
    func prepareImageItems(currentPage: Int) -> () {
        
        let networkManager: NetworkManagerProtocol
        let cacheManager: CacheManagerProtocol
        
        //проверяем есть ли кэшированные данные
        //если есть разворачиваем данные из кэша передаем в замыкание
        if let cachedData = cacheManager.getImageItems(currentPage: currentPage){
            imagesForDisplay.append(contentsOf: cachedData)
            
        //если кэша нет, то дергаем ручку
        //и разбираем ответ
        } else {
            var imageItems:[ImageDisplayModel] = []
            networkManager.getImagesFromAPI(currentPage: currentPage) { result in
                switch result {
                case .success(let answer):
                    for i in answer {
                        let imageItem = ImageDisplayModel(description: i.description ?? i.alt_description ?? "No description",
                                                          color: i.color ?? "No color",
                                                          likes: i.likes ?? 0,
                                                          imageThumb: i.urls?.thumb,
                                                          imageRegular: i.urls?.regular,
                                                          user: i.user?.username ?? "No username")
                        imageItems.append(imageItem)
                    }
                    //сохраняем в кэш с ключом = номер страницы
                    cacheManager.putImageItems(currentPage: currentPage, imageItems: imageItems)
                    
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
    

    
//    //загрузка картинки по urlToImage из новости
//    private func loadImageFile(urlToImage: String?) -> UIImage {
//        //создаем заглушку
//        var imageFile = returnImagePlaceHolder()
//        
//        //проверяем, что есть ссылка на картинку
//        //если нет, отдаем заглушку
//        guard urlToImage != nil else {
//            return imageFile
//        }
//        
//        //создаем урл из поданной строки
//        //проверяем, что создался корректный урл,
//        //если нет, отдаем заглушку
//        let createdUrlToImage = URL(string: urlToImage!)
//        guard createdUrlToImage != nil else {
//            return imageFile
//        }
//        
//        //создаем картинку по ссылке,
//        //если не создалась, отдаем заглушку
//        if let data = try? Data(contentsOf: createdUrlToImage!) {
//            imageFile = UIImage(data: data)!
//        } else {
//            return imageFile
//        }
//        return imageFile
//    }
//    
//    //создание картинки-заглушки для новости, у которой не загрузилась картинка по ссылке
//    private func returnImagePlaceHolder () -> UIImage {
//        return UIImage(named: "noImagePlaceholder")!
//    }

