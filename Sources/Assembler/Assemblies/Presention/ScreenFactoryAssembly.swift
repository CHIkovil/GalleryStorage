//
//  ScreenFactoryAssembly.swift
//  GalleryStorage
//
//  Created by Nikolas on 23.10.2023.
//

import Swinject

final class ScreensFactoryAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(ScreenFactoryProtocol.self) { resolver in
            DefaultScreensFactory()
        }
    }
}
