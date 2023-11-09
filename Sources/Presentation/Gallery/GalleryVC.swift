//
//  GalleryVC.swift
//  ImageStorage
//
//  Created by Nikolas on 23.10.2023.
//

import Foundation
import UIComponents
import Domain

class GalleryVC: BaseGalleryVC {
    
    let presenter: GalleryPresenterProtocol
    
    // MARK: - Init

    public init(presenter: GalleryPresenterProtocol) {
        self.presenter = presenter
        super.init()
    }
    
    override func getImages(completion: @escaping ([ImageModel]) -> Void) {
        self.presenter.getImages(completion: completion)
    }
}
