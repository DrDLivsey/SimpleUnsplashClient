//
//  Presenter.swift
//  SimpleUnsplashClient2
//
//  Created by Sergey Nikiforov on 06.07.2023.
//

import UIKit

protocol ImageListRepositoryProtocol {
    func getImageItems(currentPage: Int)
}

final class ImageListRepository: ImageListRepositoryProtocol {
    
    //итоговое хранилище всех моделей для отображения
    var imagesInternalModel: [ImageMetadata] = []
    
    internal func getImageItems(currentPage: Int) {
        
        let imageListRemoteDataSource: ImageListRemoteDataSourceProtocol = ImageListRemoteDataSource()
        let apiClient: APIClientProtocol = APIClient()
        let imageListLocalDataSource: ImageListLocalDataSourceProtocol = ImageListLocalDataSource()
        
        //проверяем есть ли кэшированные данные
        //если есть, разворачиваем данные из кэша добавляем к общему хранилищу
        if let cachedData = imageListLocalDataSource.getImageItems(currentPage: currentPage){
            imagesInternalModel.append(contentsOf: cachedData)
        //если кэша нет, то дергаем ручку
        //и разбираем ответ
        } else {
            apiClient.getImages(currentPage: currentPage) { result in
                switch result {
                case .success(let answer):
                    //проверяем, что удалось создать DTO модели из JSON
                    if let imageItemsDTO = imageListRemoteDataSource.convertJSONToDTO(imageDataFromAPI: answer) {
                        //если удалось, то перегоняем DTO в Internal модели
                        let imageItemsInternal = self.trasferAPIToDispModel(input: imageItemsDTO)
                        //добавляем полученные Internal модели в общее хранилище
                        self.imagesInternalModel.append(contentsOf: imageItemsInternal)
                        //сохраняем в кэш с ключом = номер страницы
                        imageListLocalDataSource.setImageItems(currentPage: currentPage, imageItems: imageItemsInternal)
                    } else {
                        print("Не удалось создать Internal-модели")
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}


extension ImageListRepository {
    func trasferAPIToDispModel(input: [ImageMetadataDTO]) -> [ImageMetadata] {
        var imageItems: [ImageMetadata] = []
        for i in input {
            let imageItem = ImageMetadata(description: i.description ?? i.alt_description ?? "No description",
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
