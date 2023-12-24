//
//  CoordinatorFactoryAssembly.swift
//  GalleryStorage
//
//  Created by Nikolas on 23.10.2023.
//

import Swinject

final class CoordinatorFactoryAssembly: Assembly {

    func assemble(container: Container) {
        container.register(CoordinatorFactoryProtocol.self) { resolver in
            DefaultContractorCoordinatorFactory(screensFactory: <~resolver)
        }
    }
}
