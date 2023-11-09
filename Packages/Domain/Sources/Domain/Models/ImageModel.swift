//
//  ImageModel.swift
//  
//
//  Created by Nikolas on 23.10.2023.
//

import Foundation

public struct ImageModel {
    public let uid: String
    public let data: Data
    
    public init(
        uid: String,
        data: Data
    ) {
        self.uid = uid
        self.data = data
    }
}
