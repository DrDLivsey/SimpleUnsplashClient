//
//  Spinner.swift
//  SimpleUnsplashClientNew
//
//  Created by Sergey Nikiforov on 09.08.2023.
//

import UIKit

final class Spinner: UIView {
    
    let spinner = UIActivityIndicatorView(style: .large)
    let label = UILabel()
    
    func startAnimating() {
        spinner.startAnimating()
    }
    
    func stopAnimating() {
        spinner.stopAnimating()
    }
    
    func configureForLoadingScreen() {
        //конфигурируем лейбл
        label.text = "Loading"
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.widthAnchor.constraint(equalToConstant: 150).isActive = true
        label.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        //создаем вертикальный стак
        //добавляем в него созданные элементы
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.spacing = 10
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.addArrangedSubview(spinner)
        stackview.addArrangedSubview(label)
        
        //создаем вью белого цвета
        let view = UIView()
        view.backgroundColor = .white
        
        //добавляем стак
        //размещаем его во вью
        view.addSubview(stackview)
        stackview.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackview.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
