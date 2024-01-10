//
//  GalleryUpdaterVC.swift
//  GalleryStorage
//
//  Created by Nikolas on 07.01.2024.
//

import UIComponents
import Foundation

class GalleryUpdaterVC: BaseGalleryUpdaterVC {

    let presenter: GalleryUpdaterPresenterProtocol

    // MARK: - Init

    public init(presenter: GalleryUpdaterPresenterProtocol) {
        self.presenter = presenter
        super.init()
    }
}
