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
    func getImage(uid: String) -> AnyPublisher<ImageModel, NetworkError>
}

open class DefaultGalleryService: GalleryServiceProtocol {
    private let api: GalleryApiProtocol

    public init(api: GalleryApiProtocol) {
        self.api = api
    }

    public func getImage(uid: String) -> AnyPublisher<ImageModel, NetworkError> {
        api.getImage(uid: uid)
            .map { ImageModel(uid: uid, data: $0) }
            .eraseToAnyPublisher()
    }
}
