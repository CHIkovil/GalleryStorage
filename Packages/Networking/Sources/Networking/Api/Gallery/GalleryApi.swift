//
//  GalleryApi.swift
//
//
//  Created by Nikolas on 23.10.2023.
//

import Alamofire
import Foundation
import Combine
import Domain

public protocol GalleryApiProtocol {
    func getImage(uid: String) -> AnyPublisher<Data, NetworkError>
}

public final class DefaultGalleryApi: BaseApi {
    
    private enum Endpoint: BaseEndpointApi {
        
        case getImage(uid: String)
        
        var method: HTTPMethod {
            switch self {
            case .getImage:
                return .get
            }
        }
        
        var path: String {
            switch self {
            case .getImage(let uid):
                return "\(uid)"
            }
        }
        
        var pathPrefix: String {
            "api/"
        }
        
        var jsonModel: Encodable? {
            return nil
        }
        
        var urlModel: Encodable? {
            nil
        }
        
        var headers: HTTPHeaders? {
            nil
        }
    }
}

extension DefaultGalleryApi: GalleryApiProtocol {
    public func getImage(uid: String) -> AnyPublisher<Data, NetworkError> {
        request(endpoint: Endpoint.getImage(uid: uid), response: Data.self)
    }
}

