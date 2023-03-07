//
//  ProductListItemView.swift
//  Parade
//
//  Created by Łukasz Szymczuk on 07/03/2023.
//

import SwiftUI
import PresentationParade
import CoreParade

struct ProductListItemView: View {
    let viewModel: ProductItemViewModel
    
    init(product: Product) {
        self.viewModel = ProductItemViewModel(product: product)
    }
    
    var body: some View {
        HStack {
            RemoteImage(urlString: viewModel.imageUrl)
                .frame(width: 70, height: 70)
                .padding(.trailing)
            
            VStack(alignment: .leading) {
                Text(viewModel.name)
                Text(viewModel.priceString)
                    .bold()
                    .font(.callout)
            }
            
            Spacer()
        }
    }
}

struct ProductListItemView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListItemView(product: Product.mock(index: 0))
    }
}
