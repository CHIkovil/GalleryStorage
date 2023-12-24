//
//  Environment.swift
//  
//
//  Created by Nikolas on 23.10.2023.
//

import Foundation

public protocol Environment {
    var host: String { get }
}

public struct DevEnvironment: Environment {
    public var host = "http://localhost:666/"

    public init() {}
}
