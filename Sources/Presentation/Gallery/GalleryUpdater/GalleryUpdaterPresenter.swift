//
//  GalleryUpdaterPresenter.swift
//  GalleryStorage
//
//  Created by Nikolas on 07.01.2024.
//

import Foundation
import Networking
import Combine

typealias GalleryUpdaterPresenterProtocol = (GalleryUpdaterPresenterServiceProtocol)

public protocol GalleryUpdaterPresenterServiceProtocol {
}

struct GalleryUpdaterOutput {}

final class GalleryUpdaterPresenter {
    private let output: GalleryUpdaterOutput
    private let galleryService: GalleryServiceProtocol
    private var cancellables = Set<AnyCancellable>()

    init(output: GalleryUpdaterOutput, galleryService: GalleryServiceProtocol) {
        self.output = output
        self.galleryService = galleryService
    }
}

// MARK: GalleryUpdaterPresenterServiceProtocol

extension GalleryUpdaterPresenter: GalleryUpdaterPresenterServiceProtocol {}
