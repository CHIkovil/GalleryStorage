//
//  SessionAssembly.swift
//  DeliveryAggregatorClient
//
//  Created by Nikolas on 23.01.2023.
//

import Foundation
import Swinject
import Alamofire
import Networking

final class SessionAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(Session.self) { resolver in
            let apiLogger: ApiLogger = <~resolver
            return Session(eventMonitors: [apiLogger])
        }
    }
}
