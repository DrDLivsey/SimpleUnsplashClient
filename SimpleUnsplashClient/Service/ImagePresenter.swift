//
//  Presenter.swift
//  SimpleUnsplashClient2
//
//  Created by Sergey Nikiforov on 06.07.2023.
//

import UIKit

protocol ImagePresenterDelegate: AnyObject {
    func presentImageItems(imageItems: [ImageItem]) -> ()
    func presentErrorMessage(errorMessage: String) -> ()
}

typealias PresenterDelegate = ImagePresenterDelegate & UIViewController

protocol ImagePresenterProtocol {
    
}

class ImagePresenter: NetworkManagerDelegate {
    
    weak var delegate: PresenterDelegate?
    private let manager = NetworkManager()
    
    func setViewDelegate(delegate: PresenterDelegate) {
        self.delegate = delegate
    }
    
    func prepareImageItems(currentPage: Int) -> () {
        
        let cache = ImageItemsCache()
        
        //проверяем есть ли кэшированные данные
        //если есть разворачиваем данные из кэша передаем в замыкание
        if let cachedData = cache.getImageItems(currentPage: currentPage){
            self.delegate?.presentImageItems(imageItems: cachedData)
            
            //если кэша нет, то дергаем ручку
            //и разбираем ответ
        } else {
            var imageItems:[ImageItem] = []
            let manager = NetworkManager()
            let urlWithPage = "https://api.unsplash.com/photos/?client_id=xscBeO9EtLaijog5ZG3GyY_jj8ee4cU_DfMCIDPsgnQ&page=" + String(currentPage)
            
            manager.setViewDelegate(delegate: self)
            manager.getData(currentPage: currentPage, urlWithPage: urlWithPage) { result in
                switch result {
                case .success(let answer):
                    for i in answer {
                        let imageItem = ImageItem(description: i.description ?? i.alt_description ?? "No description",
                                                  color: i.color ?? "No color",
                                                  likes: i.likes ?? 0,
                                                  imageThumb: self.loadImageFile(urlToImage: i.urls?.thumb),
                                                  imageRegular: self.loadImageFile(urlToImage: i.urls?.regular),
                                                  user: i.user?.username ?? "No username")
                        imageItems.append(imageItem)
                    }
                    //сохраняем в кэш с ключом = номер страницы
                    cache.putImageItems(currentPage: currentPage, imageItems: imageItems)
                    self.delegate?.presentImageItems(imageItems: imageItems)
        
                case .failure(let error):
                    print(error)
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
}
