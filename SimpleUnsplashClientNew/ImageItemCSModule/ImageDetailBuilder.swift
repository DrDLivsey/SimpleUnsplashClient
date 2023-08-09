//
//  ImageDetailBuilder.swift
//  SimpleUnsplashClientNew
//
//  Created by Sergey Nikiforov on 09.08.2023.
//

import UIKit

protocol ImageDetailBuilderProtocol {
    func make(imgID:String) -> UIViewController
}

final class ImageDetailBuilder: ImageDetailBuilderProtocol {
    func make(imgID: String) -> UIViewController {}
}
