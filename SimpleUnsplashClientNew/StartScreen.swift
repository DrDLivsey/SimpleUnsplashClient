//
//  StartScreen.swift
//  SimpleUnsplashClientNew
//
//  Created by Sergey Nikiforov on 10.08.2023.
//

import UIKit

final class StartScreen: UIViewController {
    
    @IBOutlet weak var screenTitle: UILabel?
    @IBOutlet weak var button: UIButton?
    
    private var imageCollectionBuilder: ImageCollectionBuilderProtocol = ImageCollectionBuilder()
    
    @IBAction func openImageList() {
        let imageList = imageCollectionBuilder.make()
        self.navigationController?.pushViewController(imageList, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
