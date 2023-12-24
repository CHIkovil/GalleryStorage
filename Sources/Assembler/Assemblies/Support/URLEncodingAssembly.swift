//
//  URLEncodingAssembly.swift
//  DeliveryAggregatorClient
//
//  Created by Nikolas on 23.01.2023.
//
import Swinject
import Alamofire

final class URLEncodingAssembly: Assembly {

    func assemble(container: Container) {
        container.register(URLEncoding.self) { _ in
            URLEncoding()
        }
    }
}
