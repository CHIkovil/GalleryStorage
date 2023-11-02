//
//  JSONEncodingAssembly.swift
//  DeliveryAggregatorClient
//
//  Created by Nikolas on 23.01.2023.
//

import Swinject
import Alamofire

final class JSONEncodingAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(JSONEncoding.self) { resolver in
            JSONEncoding()
        }
    }
}
