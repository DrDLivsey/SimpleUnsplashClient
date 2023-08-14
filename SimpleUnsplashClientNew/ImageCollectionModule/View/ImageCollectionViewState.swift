//
//  ImageCollectionViewState.swift
//  SimpleUnsplashClientNew
//
//  Created by Sergey Nikiforov on 09.08.2023.
//

import Foundation

enum ImageCollectionViewState {
    
    case loading
    // TODO: implement error view
    // case loadingError(Error)
    case content([ImageCollectionCellModel])
}
