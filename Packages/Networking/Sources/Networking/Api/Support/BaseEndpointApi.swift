//
//  BaseEndpointApi.swift
//
//  Created by Nikolas on 23.10.2023.
//

import Foundation
import Alamofire

public protocol BaseEndpointApi {

    var method: HTTPMethod { get }
    var path: String { get }
    var pathPrefix: String { get }
    var fullPath: String { get }
    var jsonModel: Encodable? { get }
    var urlModel: Encodable? { get }
    var headers: HTTPHeaders? {get}

    func urlParameters(encoder: JSONEncoder) -> Parameters?
    func jsonParameters(encoder: JSONEncoder) -> Parameters?
    func urlRequest(builder: RequestBuilder, encoder: JSONEncoder) -> URLRequest?
}

extension BaseEndpointApi {

    var fullPath: String {
        "\(pathPrefix == "" ? "": pathPrefix + "/")\(path)"
    }

    func urlParameters(encoder: JSONEncoder) -> Parameters? {
        urlModel?.parameters(encoder: encoder)
    }

    func jsonParameters(encoder: JSONEncoder) -> Parameters? {
        jsonModel?.parameters(encoder: encoder)
    }

    func urlRequest(builder: RequestBuilder, encoder: JSONEncoder) -> URLRequest? {
        builder.build(
            path: fullPath,
            method: method,
            urlParameters: urlParameters(encoder: encoder),
            jsonParameters: jsonParameters(encoder: encoder),
            headers: headers
        )
    }
}
