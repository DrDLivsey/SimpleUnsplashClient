//
//  ImageDetailVC.swift
//  SimpleUnsplashClientNew
//
//  Created by Sergey Nikiforov on 09.08.2023.
//

import UIKit
import Kingfisher

protocol ImageDetailVCInput: AnyObject {
    
    func configure(imageModel: ImageDetailModel)
    
}

final class ImageDetailVC: UIViewController {
    
    private let interactor: ImageDetailInteractorInput
    
    init(interactor: ImageDetailInteractorInput) {
        self.interactor = interactor
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactor.viewDidLoad()
        
    }
}

extension ImageDetailVC: ImageDetailVCInput {
    
    func configure(imageModel: ImageDetailModel) {
        let imageContainer = UIImageView()
        imageContainer.kf.setImage(with: imageModel.imageURLRegular)
        imageContainer.contentMode = .scaleAspectFill
        
        view.addSubview(imageContainer)
        imageContainer.translatesAutoresizingMaskIntoConstraints = false
        imageContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        imageContainer.bottomAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.bottomAnchor,
            constant: 0
        ).isActive = true
        imageContainer.leadingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leadingAnchor,
            constant: 0
        ).isActive = true
        imageContainer.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor,
            constant: 0
        ).isActive = true
        
        navigationItem.title = imageModel.imageUser
    }
}
