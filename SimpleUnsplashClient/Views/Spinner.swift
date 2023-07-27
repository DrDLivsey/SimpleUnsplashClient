//
//  SpinnerVC.swift
//  SimpleUnsplashClient2
//
//  Created by Sergey Nikiforov on 06.07.2023.
//

import UIKit

final class Spinner: UIView {
    
    private let spinner = UIActivityIndicatorView(style: .large)
    var label = UILabel()
    
    private func startAnimating() {
        spinner.startAnimating()
    }
    
    private func stopAnimating() {
        spinner.stopAnimating()
    }
    
}

        
        

        
    

