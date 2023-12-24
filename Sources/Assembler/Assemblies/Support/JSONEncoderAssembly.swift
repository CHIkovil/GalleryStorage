//
//  JSONEncoderAssembly.swift
//  DeliveryAggregatorClient
//
//  Created by Nikolas on 23.01.2023.
//

import Swinject
import Foundation

final class JSONEncoderAssembly: Assembly {

    func assemble(container: Container) {
        container.register(JSONEncoder.self) { _ in
            JSONEncoder()
        }
    }
}
