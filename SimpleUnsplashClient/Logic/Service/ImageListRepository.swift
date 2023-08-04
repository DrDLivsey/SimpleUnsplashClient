//
//  Presenter.swift
//  SimpleUnsplashClient2
//
//  Created by Sergey Nikiforov on 06.07.2023.
//

import UIKit

protocol ImageListRepositoryProtocol {
    var imagesInternalModel: [ImageMetadata] {get}
    func getImageItems(path: String, currentPage: Int, completion: @escaping (Result<[ImageMetadata]?, Error>) ->())
}

final class ImageListRepository: ImageListRepositoryProtocol {
    
    private enum ImageListRepositoryError: Error {
        case serverError
        case parsingError
        case networkError
    }
    
    //итоговое хранилище всех моделей для отображения
    var imagesInternalModel: [ImageMetadata] = []
    
    private let imageListRemoteDataSource: ImageListRemoteDataSourceProtocol = ImageListRemoteDataSource()
    private let imageListLocalDataSource: ImageListLocalDataSourceProtocol = ImageListLocalDataSource()
    
    func getImageItems(path: String, currentPage: Int, completion: @escaping (Result<[ImageMetadata]?, Error>) ->()) {
        //проверяем есть ли кэшированные данные
        //если есть, разворачиваем данные из кэша добавляем к общему хранилищу
        if let cachedData = imageListLocalDataSource.getImageItems(currentPage: currentPage){
            imagesInternalModel.append(contentsOf: cachedData)
            //если кэша нет, то дергаем ручку
            //и разбираем ответ
        } else {
            imageListRemoteDataSource.getDTOModels(currentPage: currentPage) { result in
                switch result {
                case .success(let resultedDTOModels):
                    guard let chechedResultedDTOModels = resultedDTOModels else {
                        return
                    }
                    let internalModelPack = self.trasferDTOToInternalModel(input: chechedResultedDTOModels)
                    self.imagesInternalModel.append(contentsOf: internalModelPack)
                case .failure(_):
                    return
                }
            }
        }
    }
}


extension ImageListRepository {
    func trasferDTOToInternalModel(input: [ImageMetadataDTO]) -> [ImageMetadata] {
        
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
