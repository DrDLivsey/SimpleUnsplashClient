//
//  ImageCollectionVC.swift
//  SimpleUnsplashClientNew
//
//  Created by Sergey Nikiforov on 09.08.2023.
//

import UIKit

protocol ImageCollectionViewInput: AnyObject {
    func configure(state: ImageCollectionViewState)
}

final class ImageCollectionVC: UICollectionViewController {
    
    private let spinner = Spinner()
    
    private let interactor: ImageCollectionInteractorInput
    
    private var dataToDisplay: [ImageCollectionCellModel] = []
    private var currentPage = 1
    private let cellName = "ImageCollectionCell"
    
    init(interactor: ImageCollectionInteractorInput) {
        self.interactor = interactor
        
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {   
        super.viewDidLoad()
        let cellTypeNib = UINib(nibName: cellName, bundle: nil)
        collectionView.register(cellTypeNib, forCellWithReuseIdentifier: cellName)
        collectionView.dataSource = self
        
        interactor.viewDidLoad(currentPage: currentPage)
        collectionView.collectionViewLayout = UICollectionViewFlowLayout.makeImageCollectionLayout()
        collectionView.contentInsetAdjustmentBehavior = .always

    }
    
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataToDisplay.count
    }
    
    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: cellName,
            for: indexPath
        )

        guard let checkedCell = (cell as? ImageCollectionCell) else {
            return cell
        }
        
        checkedCell.configure(model: dataToDisplay[indexPath.row])
        return checkedCell
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        if indexPath.item == dataToDisplay.count - 2 {
            interactor.viewDidLoad(currentPage: currentPage)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        interactor.didTapImage(
            imgID: dataToDisplay[indexPath.row].imageID,
            userName: dataToDisplay[indexPath.row].imageUser
        )
    }
}

extension ImageCollectionVC: ImageCollectionViewInput {
    func configure(state: ImageCollectionViewState) {
        switch state {
        case .loading:
            view.addSubview(spinner)
            spinner.startAnimating()

        // TODO: implement error view
        // case .loadingError(let error):

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

extension UICollectionViewFlowLayout {
    static func makeImageCollectionLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 150, height: 150)
        layout.sectionInsetReference = .fromSafeArea
        layout.sectionInset.top = 0
        layout.sectionInset.bottom = 0
        layout.sectionInset.left = 30
        layout.sectionInset.right = 30
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        return layout
    }
}
