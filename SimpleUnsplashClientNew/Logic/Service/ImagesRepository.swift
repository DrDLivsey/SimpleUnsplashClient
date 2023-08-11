//
//  ImagesRepository.swift
//  SimpleUnsplashClientNew
//
//  Created by Sergey Nikiforov on 09.08.2023.
//

import UIKit

protocol ImagesRepositoryProtocol {
    var imagesInternalModel: [ImageMetadata] {get}
    func getImageItems(
        currentPage: Int,
        completion: @escaping (Result<[ImageMetadata], ImagesRepository.ImagesRepositoryError>) -> Void
    )
    func getImageItem(
        imgID: String,
        completion: @escaping(Result<ImageMetadata, ImagesRepository.ImagesRepositoryError>) -> Void
    )
}

final class ImagesRepository: ImagesRepositoryProtocol {
    
    static let sharedInstance = ImagesRepository()
    
    enum ImagesRepositoryError: Error {
        case internalError
        case requestError
    }

    var imagesInternalModel: [ImageMetadata] {
        get {
            accessQueue.sync { _imagesInternalModel }
        }
        set {
            accessQueue.async(flags: .barrier) { [weak self] in self?._imagesInternalModel = newValue }
        }
    }
    
    private let imageListRemoteDataSource: ImageListRemoteDataSourceProtocol = ImageListRemoteDataSource()
    private let imageListLocalDataSource: ImageListLocalDataSourceProtocol = ImageListLocalDataSource()
    
    private let accessQueue = DispatchQueue(label: "ImagesRepository.accessQueue", attributes: .concurrent)
    private var _imagesInternalModel: [ImageMetadata] = []
    
    func getImageItems(
        currentPage: Int,
        completion: @escaping (Result<[ImageMetadata], ImagesRepository.ImagesRepositoryError>) -> Void
    ) {
        if let cachedData = imageListLocalDataSource.getImageItems(currentPage: currentPage) {
            imagesInternalModel.append(contentsOf: cachedData)
            completion(.success(imagesInternalModel))
        } else {
            imageListRemoteDataSource.getDTOModels(currentPage: currentPage) { [weak self] result in
                guard let self = self else {return}
                switch result {
                case .success(let dtoModels):
                    let internalModelPack = dtoModels.compactMap { $0.domainModel }
                    imageListLocalDataSource.setImageItems(currentPage: currentPage, imageItems: internalModelPack)
                    imagesInternalModel.append(contentsOf: internalModelPack)
                    completion(.success(imagesInternalModel))
                    
                case .failure(let error):
                    completion(.failure(error.imagesRepositoryError))
                }
            }
        }
    }
    
    func getImageItem(
        imgID: String,
        completion: @escaping(Result<ImageMetadata, ImagesRepository.ImagesRepositoryError>) -> Void
    ) {
        if let imageItem = imagesInternalModel.first(where: { $0.id == imgID }) {
            completion(.success(imageItem))
        } else {
            completion(.failure(.internalError))
        }
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

private extension ImageListRemoteDataSource.ImageListRemoteDataSourceError {
    var imagesRepositoryError: ImagesRepository.ImagesRepositoryError {
        switch self {
        case .internalError:
            return .internalError
        case .networkError:
            return .requestError
        }
    }
}
