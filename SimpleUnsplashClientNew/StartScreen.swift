//
//  StartScreen.swift
//  SimpleUnsplashClientNew
//
//  Created by Sergey Nikiforov on 10.08.2023.
//

import UIKit

final class StartScreen: UIViewController {
    
    @IBOutlet private weak var screenTitle: UILabel?
    @IBOutlet private weak var button: UIButton?
    
    @IBAction private func openImageList() {
        let imageCollectionBuilder: ImageCollectionBuilderProtocol = ImageCollectionBuilder()
        let imageList = imageCollectionBuilder.make()

        self.navigationController?.pushViewController(imageList, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
