//
//  ImageCollectionVC.swift
//  SimpleUnsplashClientNew
//
//  Created by Sergey Nikiforov on 09.08.2023.
//

import UIKit

protocol ImageCollectionVCInput: AnyObject {
    func configure(state: ImageCollectionViewState)
}

final class ImageCollectionVC: UICollectionViewController {
    
    private var intercator: ImageCollectionInteractorInput?
    private var dataToDisplay: [ImageCollectionCellModel] = []
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        intercator?.loadImages()
    }
    
}

extension ImageCollectionVC: ImageCollectionVCInput {
    
    func configure(state: ImageCollectionViewState) {
        switch state {
        case .loading:
            self.state = .loading
            
        case .loadingError(let error):
            self.state = .loading
            loadingView.showError(message: error.localizedDescription)
            
        case .content(let content):
            self.state = .content
            collectionView.setItems(items: content.ImageCollectionItems)
        }
    }
}
