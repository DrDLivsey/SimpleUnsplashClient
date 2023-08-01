//
//  Presenter.swift
//  SimpleUnsplashClient
//
//  Created by Sergey Nikiforov on 28.07.2023.
//

import Foundation



protocol ImagePresenerProtocol {
    func giveImageCells(input: [ImageMetadata]) -> [ImageCollectionCellModel]
    //заполнить func giveImageDetail ()
}


final class ImagePresenter {
    
    private var cellsForImageCollectionVC: [ImageCollectionCellModel] = []
    private let imageListRepository: ImageListRepositoryProtocol = ImageListRepository()
    
    

    
    
}
