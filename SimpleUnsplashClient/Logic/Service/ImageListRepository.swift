//
//  Presenter.swift
//  SimpleUnsplashClient2
//
//  Created by Sergey Nikiforov on 06.07.2023.
//

import UIKit

protocol ImageListRepositoryProtocol {
    var imagesInternalModel: [ImageMetadata] {get}
    func getImageItems(currentPage: Int)
}

final class ImageListRepository: ImageListRepositoryProtocol {
    
    //итоговое хранилище всех моделей для отображения
    var imagesInternalModel: [ImageMetadata] = []
    
    private let imageListRemoteDataSource: ImageListRemoteDataSourceProtocol = ImageListRemoteDataSource()
    private let apiClient: APIClientProtocol = APIClient()
    private let imageListLocalDataSource: ImageListLocalDataSourceProtocol = ImageListLocalDataSource()
    
    func getImageItems(currentPage: Int) {
        
        //проверяем есть ли кэшированные данные
        //если есть, разворачиваем данные из кэша добавляем к общему хранилищу
        if let cachedData = imageListLocalDataSource.getImageItems(currentPage: currentPage){
            imagesInternalModel.append(contentsOf: cachedData)
            //если кэша нет, то дергаем ручку
            //и разбираем ответ
        } else {
            apiClient.getImages(currentPage: currentPage) { result in
                switch result {
                case .success(let response):
                    //проверяем, что удалось создать DTO модели из JSON
                    if let imageItemsDTO = self.imageListRemoteDataSource.convertJSONToDTO(imageDataFromAPI: response) {
                        //если удалось, то перегоняем DTO в Internal модели
                        let imageItemsInternal = self.trasferAPIToInternalModel(input: imageItemsDTO)
                        //добавляем полученные Internal модели в общее хранилище
                        self.imagesInternalModel.append(contentsOf: imageItemsInternal)
                        //сохраняем в кэш с ключом = номер страницы
                        self.imageListLocalDataSource.setImageItems(currentPage: currentPage, imageItems: imageItemsInternal)
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
    private func trasferAPIToInternalModel(input: [ImageMetadataDTO]) -> [ImageMetadata] {
        
        return input.map { item in
            ImageMetadata(
                description: item.description ?? item.alt_description ?? "No description",
                color: item.color ?? "No color",
                likes: item.likes ?? 0,
                imageThumb: item.urls?.thumb,
                imageRegular: item.urls?.regular,
                user: item.user?.username ?? "No username"
            )
        }
    }
}
