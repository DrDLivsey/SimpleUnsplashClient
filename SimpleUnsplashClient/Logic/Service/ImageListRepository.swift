//
//  Presenter.swift
//  SimpleUnsplashClient2
//
//  Created by Sergey Nikiforov on 06.07.2023.
//
//класс, оркестратор, через который будет управляться бизнес-логика работы с загрузкой/сохранением данных по файлам
//в ImageCollectionInteractor

import UIKit

protocol ImageListRepositoryProtocol {
    var imagesInternalModel: [ImageMetadata] {get}
    func getImageItems(currentPage: Int, completion: @escaping (Result<[ImageMetadata]?, ImageListRepository.ImageListRepositoryError>) ->())
}

final class ImageListRepository: ImageListRepositoryProtocol {
    
    enum ImageListRepositoryError: Error {
        case internalErrorILR
        case externalErrorILR
    }
    
    //создаем очередь для синхронизации запросов
    //к хранилищу данных по картинкам (imagesInternalModel)
    //нужно
    private let accessQueue = DispatchQueue(label: "ImageListRepository.accessQueue")
    
    //итоговое хранилище всех моделей для отображения
    var imagesInternalModel: [ImageMetadata] = []
    
    private let imageListRemoteDataSource: ImageListRemoteDataSourceProtocol = ImageListRemoteDataSource()
    private let imageListLocalDataSource: ImageListLocalDataSourceProtocol = ImageListLocalDataSource()
    
    func getImageItems(currentPage: Int, completion: @escaping (Result<[ImageMetadata]?, ImageListRepository.ImageListRepositoryError>) ->()) {
        //проверяем есть ли кэшированные данные
        //если есть, разворачиваем данные из кэша добавляем к общему хранилищу
        if let cachedData = imageListLocalDataSource.getImageItems(currentPage: currentPage){
            self.accessQueue.sync {
                print("Loaded from cache data was added to the imagesInternalModel")
                imagesInternalModel.append(contentsOf: cachedData)
            }
            //если кэша нет, то дергаем ручку
            //и разбираем ответ
        } else {
            imageListRemoteDataSource.getDTOModels(currentPage: currentPage) { [weak self] result in
                switch result {
                case .success(let resultedDTOModels):
                    guard let chechedResultedDTOModels = resultedDTOModels else {
                        print("There was no DTOmodels to proccess")
                        completion(.failure(ImageListRepositoryError.internalErrorILR))
                        return
                    }
                    guard let internalModelPack = self?.trasferDTOToInternalModel(input: chechedResultedDTOModels) else {
                        print("Errors with encoding process DTO to InternalModel")
                        completion(.failure(ImageListRepositoryError.internalErrorILR))
                        return
                    }
                    self?.accessQueue.sync {
                        print("Loaded from API data was added to the imagesInternalModel")
                        self?.imagesInternalModel.append(contentsOf: internalModelPack)
                    }
                    
                case .failure(let error):
                    completion(.failure(self?.convertImageListRemoteDataSourceErrorToImageListRepositoryError(input: error) ?? ImageListRepositoryError.internalErrorILR))
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
    
    private func convertImageListRemoteDataSourceErrorToImageListRepositoryError(input: ImageListRemoteDataSource.ImageListRemoteDataSourceError) -> ImageListRepository.ImageListRepositoryError {
        var output: ImageListRepository.ImageListRepositoryError
        switch input {
        case .internalError:
            output = ImageListRepositoryError.internalErrorILR
        case .externalError:
            output = ImageListRepositoryError.externalErrorILR
        }
        return output
    }
}
