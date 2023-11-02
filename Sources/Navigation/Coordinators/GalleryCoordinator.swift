//
//  GalleryCoordinator.swift
//  GalleryStorage
//
//  Created by Nikolas on 23.10.2023.
//
import Navigation

final class GalleryCoordinator:BaseCoordinator, Coordinatable {
    
    var finishFlow: (() -> Void)?
    private let router: Routable
    private let screenFactory: ScreenFactoryProtocol
    
    // MARK: - Init
    
    init(router: Routable, screensFactory: ScreenFactoryProtocol) {
        self.router = router
        self.screenFactory = screensFactory
    }
    
    // MARK: - Start
    
    override func start() {
        showGallery()
    }
}

// MARK: - Private methods
private extension GalleryCoordinator {
    func showGallery() {
        
        let output = GalleryOutput()
        
        let vm = GalleryVM(output: output)
        let vc = screenFactory.makeGallery(viewModel: vm)
        
        router.setRoot(module: vc)
    }
}
