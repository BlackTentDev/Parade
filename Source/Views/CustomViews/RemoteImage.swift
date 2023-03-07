//
//  RemoteImageView.swift
//  Parade
//
//  Created by Łukasz Szymczuk on 06/03/2023.
//

import Foundation
import SwiftUI

struct RemoteImage: View {
    
    @ObservedObject private var loader: ImageLoader
    
    let contentMode: ContentMode = .fit
    
    init(urlString: String) {
        loader = ImageLoader(url: URL(string: urlString))
    }
    
    var body: some View {
        image(image: loader.image)
            .resizable()
            .aspectRatio(contentMode: contentMode)
            .transition(AnyTransition.opacity)
            .onAppear {
                loader.load()
            }
    }
    
    private func image(image: UIImage?) -> Image {
        if let image = image {
            return Image(uiImage: image)
        } else {
            //Placeholder
            return Image(systemName: "photo")
        }
    }
    
}
