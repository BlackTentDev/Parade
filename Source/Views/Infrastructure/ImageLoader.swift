//
//  ImageLoader.swift
//  Parade
//
//  Created by Łukasz Szymczuk on 06/03/2023.
//

import Foundation
import SwiftUI
import Combine

class ImageLoader: ObservableObject {
    
    @Published var image: UIImage?
    
    private let url: URL?
    private var cancellable: AnyCancellable?

    init(url: URL?) {
        self.url = url
    }

    deinit {
        cancel()
    }
    

    func load() {
        guard let url = url else {
            return
        }
        
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.image = $0 }
    }
    
    func cancel() {
        cancellable?.cancel()
    }
    
}
