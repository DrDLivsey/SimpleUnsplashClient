//
//  Spinner.swift
//  SimpleUnsplashClientNew
//
//  Created by Sergey Nikiforov on 09.08.2023.
//

import UIKit

final class Spinner: UIView {
    
    private let spinner = UIActivityIndicatorView(style: .large)
    private let label = UILabel()
    private let stackview = UIStackView()
    private let view = UIView()
    
    func startAnimating() {
        spinner.startAnimating()
    }
    
    func stopAnimating() {
        spinner.stopAnimating()
    }
    
    func configureForLoadingScreen() {
        configureLabel()
        configureStack()
        configureView()
    }

    func configureLabel() {
        label.text = "Loading"
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.widthAnchor.constraint(equalToConstant: 150).isActive = true
        label.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

    func configureStack() {
        stackview.axis = .vertical
        stackview.spacing = 10
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.addArrangedSubview(spinner)
        stackview.addArrangedSubview(label)
    }

    func configureView() {
        view.backgroundColor = .white
        view.addSubview(stackview)
        stackview.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackview.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
