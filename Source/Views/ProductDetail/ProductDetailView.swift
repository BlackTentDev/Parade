//
//  ProductDetailView.swift
//  Parade
//
//  Created by Łukasz Szymczuk on 07/03/2023.
//

import SwiftUI
import CoreParade
import PresentationParade

struct ProductDetailView: View {
    let viewModel: ProductDetailViewModel
    
    init(product: Product) {
        self.viewModel = ProductDetailViewModel(product: product)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            
            image
            
            header
            
            description
            
            Spacer()
        }
    }
    
    var image: some View {
        RemoteImage(urlString: viewModel.imageUrl)
            .frame(maxWidth: .infinity)
    }
    
    var header: some View {
        HStack {
            Text(viewModel.name)
                .font(.title)
            
            Spacer()
            
            Text(viewModel.priceString)
                .font(.body)
        }
        .padding()
    }
    
    var description: some View {
        Text(viewModel.description)
            .multilineTextAlignment(.leading)
            .padding()
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(product: Product.mock(index: 0))
    }
}
