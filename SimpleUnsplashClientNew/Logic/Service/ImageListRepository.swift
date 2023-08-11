//
//  ImageListRepository.swift
//  SimpleUnsplashClientNew
//
//  Created by Sergey Nikiforov on 09.08.2023.
//

import UIKit

protocol ImagesRepositoryProtocol {
    var imagesInternalModel: [ImageMetadata] {get}
    func getImageItems(currentPage: Int, completion: @escaping (Result<[ImageMetadata], ImageListRepository.ImageListRepositoryError>) -> Void)
    func getImageItem(imgID: String, completion: @escaping(Result<ImageMetadata, ImageListRepository.ImageListRepositoryError>) -> Void)
}

final class ImageListRepository: ImagesRepositoryProtocol {
    
    static var sharedInstance = ImageListRepository()
    
    enum ImageListRepositoryError: Error {
        case internalError
        case requestError
    }
    
    // доступная для работы извне переменная-дубль _imagesInternalModel
    var imagesInternalModel: [ImageMetadata] {
        accessQueue.sync {
            _imagesInternalModel
        }
    }
    
    private let imageListRemoteDataSource: ImageListRemoteDataSourceProtocol = ImageListRemoteDataSource()
    private let imageListLocalDataSource: ImageListLocalDataSourceProtocol = ImageListLocalDataSource()
    
    private let accessQueue = DispatchQueue(label: "ImageListRepository.accessQueue", attributes: .concurrent)
    // итоговое хранилище всех моделей для отображения
    private var _imagesInternalModel: [ImageMetadata] = []
    
    func getImageItems(currentPage: Int, completion: @escaping (Result<[ImageMetadata], ImageListRepository.ImageListRepositoryError>) -> Void) {
        // проверяем есть ли кэшированные данные
        // если есть, разворачиваем данные из кэша добавляем к общему хранилищу
        if let cachedData = imageListLocalDataSource.getImageItems(currentPage: currentPage) {
            accessQueue.async(flags: .barrier) { [weak self] in
                guard let self = self else {return}
                print("Loaded from cache data was added to the _imagesInternalModel")
                self._imagesInternalModel.append(contentsOf: cachedData)
                completion(.success(imagesInternalModel))
            }
            // если кэша нет, то дергаем ручку
            // разбираем ответ
        } else {
            imageListRemoteDataSource.getDTOModels(currentPage: currentPage) { [weak self] result in
                guard let self = self else {return}
                switch result {
                case .success(let dtoModels):
                    let internalModelPack = dtoModels.compactMap { $0.domainModel }
                    imageListLocalDataSource.setImageItems(currentPage: currentPage, imageItems: internalModelPack)
                    accessQueue.async(flags: .barrier) { [weak self] in
                        guard let self = self else {return}
                        print("Loaded from API data was added to the _imagesInternalModel")
                        self._imagesInternalModel.append(contentsOf: internalModelPack)
                        completion(.success(_imagesInternalModel))
                    }
                    
                case .failure(let error):
                    completion(.failure(self.convertImageListRemoteDataSourceErrorToImageListRepositoryError(
                        input: error
                    )))
                }
            }
        }
    }
    
    func getImageItem(imgID: String, completion: @escaping(Result<ImageMetadata, ImageListRepository.ImageListRepositoryError>) -> Void) {
        if let imageItem = _imagesInternalModel.first(where: { $0.id == imgID }) {
            completion(.success(imageItem))
        } else {
            completion(.failure(ImageListRepositoryError.internalError))
        }
    }
}


private extension ImageListRepository {
    private func convertImageListRemoteDataSourceErrorToImageListRepositoryError(input: ImageListRemoteDataSource.ImageListRemoteDataSourceError) -> ImageListRepository.ImageListRepositoryError {
        var output: ImageListRepository.ImageListRepositoryError
        switch input {
        case .internalError:
            output = ImageListRepositoryError.internalError
        case .networkError:
            output = ImageListRepositoryError.requestError
        }
        return output
    }
}

private extension ImageMetadataDTO {
    var domainModel: ImageMetadata? {
        guard urls?.thumb != nil && urls?.regular != nil else {
            return nil
        }
        
        return ImageMetadata(
            id: id ?? "No id",
            color: color ?? "No color",
            description: description ?? altDescription ?? "No description",
            imageThumb: urls?.thumb,
            imageRegular: urls?.regular,
            likes: likes ?? 0,
            user: user?.username ?? "No username")
    }
}
