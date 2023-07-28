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
    
    //итоговое хранилище всех моделей для отображения
    private var imagesForDisplay: [ImageDisplayModel] = []
    
    internal func prepareImageItems(currentPage: Int) -> () {
        
        let networkManager: NetworkManagerProtocol = NetworkManager()
        let cacheManager: CacheManagerProtocol = CacheManager()
        
        //проверяем есть ли кэшированные данные
        //если есть, разворачиваем данные из кэша добавляем к общему хранилищу
        if let cachedData = cacheManager.getImageItems(currentPage: currentPage){
            imagesForDisplay.append(contentsOf: cachedData)
        //если кэша нет, то дергаем ручку
        //и разбираем ответ
        } else {
            networkManager.getImagesFromAPI(currentPage: currentPage) { result in
                switch result {
                case .success(let answer):
                    var imageItems = self.trasferAPIToDispModel(input: answer)
                    //добавляем полученные модели в общее хранилище
                    self.imagesForDisplay.append(contentsOf: imageItems)
                    //сохраняем в кэш с ключом = номер страницы
                    cacheManager.putImageItems(currentPage: currentPage, imageItems: imageItems)
                    
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}


extension ImageManager {
    func trasferAPIToDispModel(input: [ImageAPIModel]) -> [ImageDisplayModel] {
        var imageItems: [ImageDisplayModel] = []
        for i in input {
            let imageItem = ImageDisplayModel(description: i.description ?? i.alt_description ?? "No description",
                                              color: i.color ?? "No color",
                                              likes: i.likes ?? 0,
                                              imageThumb: i.urls?.thumb ?? "No URL",
                                              imageRegular: i.urls?.regular ?? "No URL",
                                              user: i.user?.username ?? "No username")
            imageItems.append(imageItem)
        }
        
        return imageItems
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

