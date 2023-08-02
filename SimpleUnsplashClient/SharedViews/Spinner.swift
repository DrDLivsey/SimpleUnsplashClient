//
//  SpinnerVC.swift
//  SimpleUnsplashClient2
//
//  Created by Sergey Nikiforov on 06.07.2023.
//

import UIKit

final class Spinner: UIView {
    
    private let spinner = UIActivityIndicatorView(style: .large)
    private let label = UILabel()
    
    private func startAnimating() {
        spinner.startAnimating()
    }
    
    private func stopAnimating() {
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



//Надо ли сюда вставлять метод по настройке заглушки, которая показывается при загрузке приложения?
//Или это лучше реализовать во вью-контроллере со списком?


