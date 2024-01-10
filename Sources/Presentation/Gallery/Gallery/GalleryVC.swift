//
//  GalleryVC.swift
//  ImageStorage
//
//  Created by Nikolas on 23.10.2023.
//

import Foundation
import UIComponents
import Domain
import Networking
import UIKit

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

    override func moveToUpdater() {
        let output = GalleryUpdaterOutput()

        let presenter = GalleryUpdaterPresenter(output: output, galleryService: resolve(type: GalleryServiceProtocol.self))

        let vc = GalleryUpdaterVC(presenter: presenter)
        vc.preferredContentSize = CGSize(width: 300, height: 530)

        let backgroundColor: UIColor = traitCollection.userInterfaceStyle == .light ? .black : .gray

        self.presentBottomSheetInsideNavigationController(viewController: vc, configuration: .init(cornerRadius: 30, pullBarConfiguration: .hidden, shadowConfiguration: .init(backgroundColor: backgroundColor.withAlphaComponent(0.65))))
    }
}
