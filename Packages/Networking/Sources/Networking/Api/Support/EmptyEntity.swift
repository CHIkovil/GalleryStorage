//
//  EmptyEntity.swift
//
//  Created by Nikolas on 23.10.2023.
//

import Foundation
import Alamofire

public struct EmptyEntity: Codable, EmptyResponse {

    public static func emptyValue() -> EmptyEntity {
        EmptyEntity.init()
    }
}
