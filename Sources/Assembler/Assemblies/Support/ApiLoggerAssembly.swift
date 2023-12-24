//
//  ApiLoggerAssembly.swift
//  DeliveryAggregatorClient
//
//  Created by Nikolas on 23.01.2023.
//
import Swinject
import Alamofire
import Networking
import os

final class ApiLoggerAssembly: Assembly {

    func assemble(container: Container) {
        container.register(ApiLogger.self) { resolver in
            ApiLogger(logger: <~resolver)
        }
    }
}
