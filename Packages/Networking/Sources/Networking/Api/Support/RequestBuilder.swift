//
//  RequestBuilder.swift
//
//  Created by Nikolas on 23.10.2023.
//

import Foundation
import Alamofire
import Domain

public final class RequestBuilder {
    
    private let env: Environment
    private let urlEncoding: URLEncoding
    private let jsonEncoding: JSONEncoding
    private let jsonEncoder: JSONEncoder
    
    private var host: String {
        env.host
    }
    
    private var urlParameters: Parameters {
        [:]
    }

    // MARK: - Init
    
    public init(
        environment: Environment,
        urlEncoding: URLEncoding,
        jsonEncoding: JSONEncoding,
        jsonEncoder: JSONEncoder
    ) {
        self.env = environment
        self.urlEncoding = urlEncoding
        self.jsonEncoding = jsonEncoding
        self.jsonEncoder = jsonEncoder
    }
    
    // MARK: - Build
    
    func build<T: Encodable>(
        path: String,
        method: HTTPMethod,
        urlParametersModel: T? = nil,
        jsonParametersModel: T? = nil,
        headers: HTTPHeaders?
    ) -> URLRequest? {
        build(
            path: path,
            method: method,
            urlParameters: urlParametersModel
                .flatMap { $0.parameters(encoder: jsonEncoder) } ?? [:],
            jsonParameters: jsonParametersModel
                .flatMap { $0.parameters(encoder: jsonEncoder) } ?? [:],
            headers: headers
        )
    }
    
    func build(
         path: String,
         method: HTTPMethod,
         urlParameters: Parameters?,
         jsonParameters: Parameters?,
         headers: HTTPHeaders?
    ) -> URLRequest? {
        let urlParameters = self.urlParameters.merging(
            urlParameters ?? [:],
            uniquingKeysWith: { _, value in value }
        )
        
        var urlRequest = URL(string: host)
            .map { $0.appendingPathComponent(path) }
            .flatMap { try? urlEncoding.encode(URLRequest(url: $0), with: urlParameters) }
        
        if let jsonParameters {
            urlRequest = urlRequest
                .flatMap { try? jsonEncoding.encode($0, with: jsonParameters) }
        }
        
        urlRequest?.method = method
        
        if let headers = headers {
            urlRequest?.headers = headers
        }
        
        urlRequest?.cachePolicy = .reloadIgnoringLocalCacheData
        
        return urlRequest
    }
}
