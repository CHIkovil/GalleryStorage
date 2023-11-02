//
//  JSONDecoderAssembly.swift
//  DeliveryAggregatorClient
//
//  Created by Nikolas on 23.01.2023.
//

import Foundation
import Swinject

final class JSONDecoderAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(JSONDecoder.self) { resolver in
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            return decoder
        }
    }
}
