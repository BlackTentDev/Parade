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
        RemoteImage(urlString: "")
            .frame(maxWidth: .infinity)
    }
    
    var header: some View {
        HStack {
            Text("Product")
                .font(.title)
            
            Spacer()
            
            Text("1.23")
                .font(.body)
        }
        .padding()
    }
    
    var description: some View {
        Text("Desc")
            .multilineTextAlignment(.leading)
            .padding()
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(product: Product.mock(index: 0))
    }
}
