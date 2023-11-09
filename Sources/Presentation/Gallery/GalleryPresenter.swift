//
//  GalleryPresenter.swift
//  ImageStorage
//
//  Created by Nikolas on 23.10.2023.
//
import Combine
import Domain
import Networking

typealias GalleryPresenterProtocol = (GalleryPresenterServiceProtocol)

public protocol GalleryPresenterServiceProtocol {
    func getImages(completion: @escaping ([ImageModel]) -> Void)
}


struct GalleryOutput {}

final class GalleryPresenter {
    private let output: GalleryOutput
    private let galleryService: GalleryServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(output: GalleryOutput, galleryService: GalleryServiceProtocol) {
        self.output = output
        self.galleryService = galleryService
    }
}

//MARK: GalleryPresenterServiceProtocol

extension GalleryPresenter: GalleryPresenterServiceProtocol {
    func getImages(completion: @escaping ([ImageModel]) -> Void) {
       // Soon:
    }
}

