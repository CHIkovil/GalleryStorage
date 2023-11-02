//
//  GalleryApiAssembly.swift
//  GalleryStorage
//
//  Created by Nikolas on 23.10.2023.
//

import Swinject
import Networking

final class GalleryApiAssembly: Assembly {
    func assemble(container: Container) {
        container.register(GalleryApiProtocol.self) { resolver in
            DefaultGalleryApi(
                logger: <~resolver,
                requestBuilder: <~resolver,
                session: <~resolver,
                encoder: <~resolver,
                decoder: <~resolver
            )
        }
    }
}
