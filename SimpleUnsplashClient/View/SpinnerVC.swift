//
//  SpinnerVC.swift
//  SimpleUnsplashClient2
//
//  Created by Sergey Nikiforov on 06.07.2023.
//

import UIKit

class SpinnerVC: UIViewController {
    
    //создаем индикатор загрузки
    let spinner = UIActivityIndicatorView(style: .large)
    //создаем лейбл для подписи к нему
    let label = UILabel()
    
    
    override func viewDidLoad() {
        //запускаем анимацию индикатора
        spinner.startAnimating()
        
        //настраиваем лейбл
        label.widthAnchor.constraint(equalToConstant: 150).isActive = true
        label.heightAnchor.constraint(equalToConstant: 50).isActive = true
        label.textAlignment = .center
        label.text = "Loading"
        label.font = .preferredFont(forTextStyle: .largeTitle)
        
        //создаем вертикальный стак
        //добавляем в него созданные элементы
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.spacing = 10
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.addArrangedSubview(spinner)
        stackview.addArrangedSubview(label)
        
        //создаем вью белого цвета
        view = UIView()
        view.backgroundColor = .white
        
        //добавляем стак
        //размещаем его во вью
        view.addSubview(stackview)
        stackview.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackview.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
    }
}
