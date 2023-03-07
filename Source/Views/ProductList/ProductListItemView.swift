//
//  ProductListItemView.swift
//  Parade
//
//  Created by Łukasz Szymczuk on 07/03/2023.
//

import SwiftUI

struct ProductListItemView: View {
    let name: String
    let price: Double
    let imageUrl: String
    
    var priceString: String {
        String(format: "%.2f", price)
    }
    
    var body: some View {
        HStack {
            RemoteImage(urlString: imageUrl)
                .frame(width: 70, height: 70)
                .padding(.trailing)
            
            VStack(alignment: .leading) {
                Text(name)
                Text(priceString)
                    .bold()
                    .font(.callout)
            }
            
            Spacer()
        }
    }
}

struct ProductListItemView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListItemView(name: "Product", price: 1.0, imageUrl: String.dummyImageUrl)
    }
}
