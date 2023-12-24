//
//  ScreenFactory.swift
//  ImageStorage
//
//  Created by Nikolas on 23.10.2023.
//

import UIKit
import Navigation
import UIComponents

protocol ScreenFactoryProtocol {
    func makeGallery(presenter: GalleryPresenterProtocol) -> GalleryVC
}

final class DefaultScreensFactory: ScreenFactoryProtocol {

    // MARK: - Make

    func makeGallery(presenter: GalleryPresenterProtocol) -> GalleryVC {
        let vc = GalleryVC(presenter: presenter)
        return vc
    }
}
