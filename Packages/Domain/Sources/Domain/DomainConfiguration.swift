//
//  DomainConfiguration.swift
//  
//
//  Created by Nikolas on 23.10.2023.
//

import Swinject

public struct DomainConfiguration {
    
    public static var assembler: Assembler!
    public static var environment = DevEnvironment()
}
