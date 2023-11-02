//
//  Publisher+mapNetworkError.swift
//
//  Created by Nikolas on 23.10.2023.
//

import Foundation
import Combine
import Alamofire

extension Publisher {
    public func mapNetworkError(
    ) -> Publishers.MapError<Self, NetworkError> where Failure == AFError {
        mapError {
            $0.responseCode.flatMap { NetworkError.remote(statusCode: $0) } ?? .undefined
        }
    }
}
