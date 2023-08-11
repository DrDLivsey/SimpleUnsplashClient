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
    
    var spinner = Spinner()
    var alert = Alert()
    
    private var interactor: ImageCollectionInteractorInput
    private var builder: ImageCollectionBuilderProtocol = ImageCollectionBuilder()
    
    private var dataToDisplay: [ImageCollectionCellModel] = []
    private var currentPage = 1
    
    init(intercator: ImageCollectionInteractorInput) {
        self.interactor = intercator
        
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {   
        super.viewDidLoad()
        let cellTypeNib = UINib(nibName: "ImageCollectionCell", bundle: nil)
        collectionView.register(cellTypeNib, forCellWithReuseIdentifier: "ImageCollectionCell")
        collectionView.dataSource = self
        
        interactor.viewDidLoad(currentPage: currentPage)
        self.setupLayout()
    }
    
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataToDisplay.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "ImageCollectionCell",
            for: indexPath
        )

        guard let checkedCell = (cell as? ImageCollectionCell) else {
            return cell
        }
        
        checkedCell.configure(model: dataToDisplay[indexPath.row])
        return checkedCell
    }

    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == dataToDisplay.count - 2 {
            interactor.viewDidLoad(currentPage: currentPage)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        interactor.didTapImage(imgID: dataToDisplay[indexPath.row].imageID)
    }
}

extension ImageCollectionVC: ImageCollectionVCInput {
    func configure(state: ImageCollectionViewState) {
        switch state {
        case .loading:
            view.addSubview(spinner)
            spinner.configureForLoadingScreen()
            spinner.startAnimating()

            
        case .loadingError(let error):
            self.present(alert.configureForRetryError(error), animated: true)
            alert.addAction(UIAlertAction(
                title: "Да",
                style: .default)
            )
            
            
        case .content(let imagesForCollection):
            spinner.stopAnimating()
            spinner.removeFromSuperview()
            dataToDisplay = imagesForCollection
            currentPage += 1
            collectionView.reloadData()
        }
    }
}

extension ImageCollectionVC {
    func didTapRetry() {
        interactor.didTapRetryLoading()
    }
}

extension ImageCollectionVC {
    // настройка отображения UICollection
    private func setupLayout() {
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
