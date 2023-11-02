//
//  GalleryServiceAssembly.swift
//  GalleryStorage
//
//  Created by Nikolas on 23.10.2023.
//

import Swinject
import Networking

final class GalleryServiceAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(GalleryServiceProtocol.self) { resolver in
            DefaultGalleryService(api: <~resolver)
        }
    }
}
