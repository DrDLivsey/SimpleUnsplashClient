//
//  ImageDetailVC.swift
//  SimpleUnsplashClientNew
//
//  Created by Sergey Nikiforov on 09.08.2023.
//

import UIKit

protocol ImageDetailVCInput: AnyObject {

}

final class ImageDetailVC: ImageDetailVCInput {
    
}
//class ImageDetailVC: UIViewController {
//
//    private var selectedImageItem: ImageItemProtocol = ImageItem(description: "",
//                                                                  color: "",
//                                                                  likes: 0,
//                                                                  imageThumb: UIImage(),
//                                                                  imageRegular: UIImage(),
//                                                                  user: "")
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupDetailView()
//    }
//
//    func setSelectImageItem(selectedImageItem: ImageItemProtocol) {
//        self.selectedImageItem = selectedImageItem
//    }
//
//    private func setupDetailView() {
//        let imageContainer = UIImageView(image: selectedImageItem.imageRegular)
//        imageContainer.contentMode = .scaleAspectFit
//
//        view.addSubview(imageContainer)
//        imageContainer.translatesAutoresizingMaskIntoConstraints = false
//        imageContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
//        imageContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
//        imageContainer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
//        imageContainer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
//
//        navigationItem.title = selectedImageItem.user
//    }
//}
