//
//  ApiError.swift
//
//  Created by Nikolas on 23.10.2023.
//

import Foundation
import Alamofire

public enum NetworkError: Error {
    case remote(statusCode: Int)
    case failedBuildRequest
    case noResponse
    case undefined
    case unauthorized
}
