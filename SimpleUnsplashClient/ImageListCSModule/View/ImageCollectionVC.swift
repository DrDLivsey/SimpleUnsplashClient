//
//  ImageCollectionVC.swift
//  SimpleUnsplashClient2
//
//  Created by Sergey Nikiforov on 06.07.2023.
//

import UIKit

protocol ViewInput: AnyObject {
    func display(imagesForDisplay:[ImageCollectionCellModel])
}

final class ImageCollectionVC: UICollectionViewController {
    
    private var intercator: InteractorInput?
    private var dataToDisplay: [ImageCollectionCellModel] = [] 
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    //настройка связей через иницилизацию переменных
    private func setup() {
        let viewController = self
        let presenter = ImageCollectionPresenter()
        let interactor = ImageCollectionInteractor()
        presenter.viewController = viewController
        interactor.presenter = presenter
        viewController.intercator = interactor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        intercator?.fetchImages()
    }
    
}

extension ImageCollectionVC: ViewInput {
    func display(imagesForDisplay:[ImageCollectionCellModel]){}
}
