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
    func makeGallery(viewModel: GalleryVMProtocol) -> GalleryVC
}

final class DefaultScreensFactory: ScreenFactoryProtocol {
    
    // MARK: - Make
    
    func makeGallery(viewModel: GalleryVMProtocol) -> GalleryVC {
        let vc = GalleryVC(viewModel: viewModel)
        return vc
    }
}

