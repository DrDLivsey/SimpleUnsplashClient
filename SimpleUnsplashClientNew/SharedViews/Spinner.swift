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

    init() {
        super.init(frame: CGRect(
            x: 0,
            y: 0,
            width: view.frame.size.width,
            height: view.frame.size.height
        ))
        configureLabel()
        configureStack()
        configureView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
