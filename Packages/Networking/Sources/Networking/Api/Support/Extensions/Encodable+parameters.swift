//
//  Encodable+parameters.swift
//
//  Created by Nikolas on 23.10.2023.
//

import Foundation
import Alamofire

extension Encodable {
    func parameters(
        encoder: JSONEncoder,
        options: JSONSerialization.ReadingOptions = .fragmentsAllowed
    ) -> Parameters? {
        let data = try? encoder.encode(self)

        return data
            .flatMap { try? JSONSerialization.jsonObject(with: $0, options: options) }
            .flatMap { $0 as? Parameters }
    }
}
