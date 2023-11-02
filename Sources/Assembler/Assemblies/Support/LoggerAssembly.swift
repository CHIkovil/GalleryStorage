//
//  LoggerAssembly.swift
//  GalleryStorage
//
//  Created by Nikolas on 23.10.2023.
//

import Swinject
import Foundation
import os

final class LoggerAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(Logger.self) { resolver in
            Logger()
        }
    }
}
