//
//  RootAssembler.swift
//  GalleryStorage
//
//  Created by Nikolas on 23.10.2023.
//

import Swinject

public struct RootAssembler {
    
    // MARK: - Assemblies
    private static var apiAssemblies: [Assembly] {
        [
            URLEncodingAssembly(),
            JSONEncodingAssembly(),
            JSONEncoderAssembly(),
            JSONDecoderAssembly(),
            RequestBuilderAssembly(),
            ApiLoggerAssembly(),
            SessionAssembly(),
            GalleryApiAssembly(),
        ]
    }
    
    private static var servicesAssemblies: [Assembly] {
        [
            LoggerAssembly(),
            GalleryServiceAssembly()
        ]
    }
    
    private static var presentationAssemblies: [Assembly] {
        [
            ScreensFactoryAssembly()
        ]
    }
    
    private static var navigationAssemblies: [Assembly] {
        [
            CoordinatorFactoryAssembly()
        ]
    }
    
    private static var assemblies: [Assembly] {
        apiAssemblies
            + servicesAssemblies
            + presentationAssemblies
            + navigationAssemblies
    }
    // MARK: - Singleton
    
    public static let shared: Assembler = {
        let assembler = Assembler(assemblies)
        return assembler
    }()
    
    private init() {}
}

prefix operator <?
prefix func <? <Service>(_ resolver: Resolver) -> Service? {
    resolver.resolve(Service.self)
}

prefix operator <~
prefix func <~ <Service>(_ resolver: Resolver) -> Service {
    (<?resolver)!
}

public func resolve<Service>(type: Service.Type, name: String? = nil) -> Service {
    RootAssembler.shared.resolver.resolve(type, name: name)!
}
