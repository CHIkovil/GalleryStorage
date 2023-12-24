//
//  BaseApi.swift
//
//  Created by Nikolas on 23.10.2023.
//

import Foundation
import os
import Domain
import Alamofire
import Combine

public class BaseApi {

    let logger: Logger
    private let requestBuilder: RequestBuilder
    private let session: Session
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder

    // MARK: - Init

    public init(
        logger: Logger,
        requestBuilder: RequestBuilder,
        session: Session,
        encoder: JSONEncoder,
        decoder: JSONDecoder
    ) {
        self.logger = logger
        self.requestBuilder = requestBuilder
        self.session = session
        self.encoder = encoder
        self.decoder = decoder
    }

    public func request(endpoint: BaseEndpointApi) -> AnyPublisher<EmptyEntity, NetworkError> {
        request(endpoint.urlRequest(builder: requestBuilder, encoder: encoder), response: EmptyEntity.self)
    }

    public func request<T: Decodable>(endpoint: BaseEndpointApi, response: T.Type) -> AnyPublisher<T, NetworkError> {
        request(endpoint.urlRequest(builder: requestBuilder, encoder: encoder), response: T.self)
    }
}

private extension BaseApi {
    func request<T: Decodable>(
        _ urlRequest: URLRequestConvertible?,
        response: T.Type
    ) -> AnyPublisher<T, NetworkError> {
        guard let urlRequest = urlRequest else {
            return Fail(error: NetworkError.failedBuildRequest).eraseToAnyPublisher()
        }

        let request = session.request(urlRequest)

        return request.validate()
            .publishDecodable(type: T.self, queue: .global(), decoder: decoder)
            .value()
            .mapNetworkError()
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()

    }
}
