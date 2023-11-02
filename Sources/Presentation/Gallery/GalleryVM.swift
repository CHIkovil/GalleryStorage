//
//  GalleryVM.swift
//  ImageStorage
//
//  Created by Nikolas on 23.10.2023.
//
import Combine
import UIComponents

struct GalleryOutput {}

final class GalleryVM {
    private let output: GalleryOutput
    private var cancellables = Set<AnyCancellable>()
    
    init(output: GalleryOutput) {
        self.output = output
    }
}

//MARK: GalleryVMProtocol

extension GalleryVM: GalleryVMProtocol {
    
}

