//
//  RequestBuilderAssembly.swift
//  DeliveryAggregatorClient
//
//  Created by Nikolas on 23.01.2023.
//

import Swinject
import Networking
import Domain

final class RequestBuilderAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(RequestBuilder.self) { resolver in
            RequestBuilder(
                environment: DomainConfiguration.environment,
                urlEncoding: <~resolver,
                jsonEncoding: <~resolver,
                jsonEncoder: <~resolver
            )
        }
    }
}
