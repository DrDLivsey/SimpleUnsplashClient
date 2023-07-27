//
//  ImageCollectionVC.swift
//  SimpleUnsplashClient2
//
//  Created by Sergey Nikiforov on 06.07.2023.
//

import UIKit

class ImageCollectionVC: UICollectionViewController, ImagePresenterDelegate {
    
    private var imagesCollection: [ImageCollectionCellModel] = []
    private let presenter = ImagePresenter()
    private var currentPage = 1
    private var errorMessage = ""
    private let spinner = Spinner()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        
        let cellTypeNib = UINib(nibName: "ImageCollectionCell", bundle: nil)
        collectionView.register(cellTypeNib, forCellWithReuseIdentifier: "ImageCollectionCell")
        
        
        presenter.setViewDelegate(delegate: self)
        
        let dispatchQueue = DispatchQueue.global()
        dispatchQueue.async {
            self.presenter.prepareImageItems(currentPage: self.currentPage)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesCollection.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionCell", for: indexPath) as! ImageCollectionCell
        cellConfigure(cell: &cell, for: indexPath)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == imagesCollection.count - 2 {
            loadData()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let imageDetailScreen = storyboard.instantiateViewController(withIdentifier: "ImageDetailVC") as! ImageDetailVC
        imageDetailScreen.setSelectImageItem(selectedImageItem: imagesCollection[indexPath.row])
        self.navigationController?.pushViewController(imageDetailScreen, animated: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.dismiss(animated: false)
    }
    
    internal func presentImageItems(imageItems: [ImageItem]) -> () {
        self.imagesCollection.append(contentsOf: imageItems)
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.spinner.view.removeFromSuperview()
            self.spinner.removeFromParent()
        }
    }
    
    internal func presentErrorMessage(errorMessage: String) -> () {
        self.errorMessage = errorMessage
        if errorMessage != "" {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Error message", message: errorMessage, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Reload", style: .default) { _ in
                    self.loadData()
                })
                self.present(alert, animated: true)
            }
        }
    }
    
    private func loadData() {
        currentPage += 1
        let dispatchQueue = DispatchQueue.global()
        dispatchQueue.async {
            self.presenter.prepareImageItems(currentPage: self.currentPage)
        }
    }
    
//    //настройка ячейки
//    private func cellConfigure (cell: inout ImageCollectionCell, for indexPath: IndexPath) {
//        let imageItem = imagesCollection[indexPath.row]
//        let textUIColor = UIColor(hex: imageItem.color)
//        let attributedLinkString = NSAttributedString(string: "\(imageItem.description)",
//                                                      attributes: [NSAttributedString.Key.foregroundColor : textUIColor])
//        
//        cell.imageDescription?.attributedText = attributedLinkString
//        cell.imageThumb?.image = imageItem.imageThumb
//        cell.imageLikes?.text = "\u{1F44D}: \(imageItem.likes)"
//    }
    
    //настройка отображения UICollection
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
    
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 150, height: 150)
        collectionView.contentInsetAdjustmentBehavior = .always
        layout.sectionInsetReference = .fromSafeArea
        layout.sectionInset.top = 0
        layout.sectionInset.bottom = 0
        layout.sectionInset.left = 30
        layout.sectionInset.right = 30
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        self.collectionView.collectionViewLayout = layout
    }
}
