//
//  GalleryService.swift
//
//  Created by Nikolas on 23.10.2023.
//

import Foundation
import Combine
import Alamofire
import Domain

public protocol GalleryServiceProtocol {
    func getImage(id: Int) -> AnyPublisher<ImageModel, NetworkError>
}

open class DefaultGalleryService: GalleryServiceProtocol {
    private let api: GalleryApiProtocol
    
    public init(api: GalleryApiProtocol) {
        self.api = api
    }
    
    public func getImage(id: Int) -> AnyPublisher<ImageModel, NetworkError> {
        api.getImage(id: id)
            .map { ImageModel(id: id, data: $0) }
            .eraseToAnyPublisher()
    }
}

