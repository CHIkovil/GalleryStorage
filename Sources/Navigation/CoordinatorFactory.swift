//
//  CoordinatorFactory.swift
//  ImageStorage
//
//  Created by Nikolas on 23.10.2023.
//

import Foundation
import Navigation

protocol CoordinatorFactoryProtocol {
    func makeRootCoordinator(router: Routable) -> Coordinatable
    func makeGalleryCoordinator(router: Routable) -> Coordinatable
}

final class DefaultContractorCoordinatorFactory: CoordinatorFactoryProtocol {
    
    private let screensFactory: ScreenFactoryProtocol
    
    // MARK: - Init
    
    init(screensFactory: ScreenFactoryProtocol) {
        self.screensFactory = screensFactory
    }
    
    func makeRootCoordinator(router: Routable) -> Coordinatable {
        RootCoordinator(router: router, coordinatorFactory: self)
    }
    
    func makeGalleryCoordinator(router: Routable) -> Coordinatable {
        GalleryCoordinator(router: router, screensFactory: screensFactory)
    }
    
}
