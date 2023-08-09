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
    
    private var intercator: ImageCollectionInteractorInput
    private var dataToDisplay: [ImageCollectionCellModel] = []
    
    var spinner = Spinner()
    var alert = Alert()
    
    init(intercator: ImageCollectionInteractorInput){
        self.intercator = intercator
        
        super.init(nibName: String?, bundle: Bundle?)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {   
        super.viewDidLoad()
        
        
    }
    
}

extension ImageCollectionVC: ImageCollectionVCInput {
    
    func configure(state: ImageCollectionViewState) {
        switch state {
        case .loading:
            spinner.configureForLoadingScreen()
            spinner.startAnimating()
            view.addSubview(spinner)
            
        case .loadingError(let error):
            self.present(alert.configureForRetryError(error), animated: true)
            
            
        case .content
            dataToDisplay
        }
    }
}

extension ImageCollectionVC {
    func didTapRetry() {
        intercator.didTapRetryLoading()
    }
}


