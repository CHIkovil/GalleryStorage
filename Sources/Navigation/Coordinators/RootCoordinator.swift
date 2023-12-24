//
//  RootCoordinator.swift
//  ImageStorage
//
//  Created by Nikolas on 23.10.2023.
//
import Navigation

final class RootCoordinator: BaseCoordinator, Coordinatable {

    var finishFlow: (() -> Void)?
    private let router: Routable
    private let coordinatorFactory: CoordinatorFactoryProtocol

    // MARK: - Init

    init(router: Routable, coordinatorFactory: CoordinatorFactoryProtocol) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
    }

    // MARK: - Start

    override func start() {
        performGalleryFlow()
    }
}

// MARK: - Private methods
private extension RootCoordinator {
    func performGalleryFlow() {
        let coordinator = coordinatorFactory.makeGalleryCoordinator(router: router)
        coordinator.finishFlow = {}

        add(coordinator: coordinator)
        coordinator.start()
    }
}
