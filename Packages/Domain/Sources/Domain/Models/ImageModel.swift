//
//  ImageModel.swift
//  
//
//  Created by Nikolas on 23.10.2023.
//

import Foundation

public struct ImageModel {
    public let id: Int
    public let data: Data
    
    public init(
        id: Int,
        data: Data
    ) {
        self.id = id
        self.data = data
    }
}
