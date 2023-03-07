//
//  ProductDetailViewModel.swift
//  
//
//  Created by Łukasz Szymczuk on 07/03/2023.
//

import Foundation
import CoreParade

public struct ProductDetailViewModel {
    private let product: Product
    
    public init(product: Product) {
        self.product = product
    }
    
    public var name: String {
        product.name
    }
    
    public var imageUrl: String {
        product.imageUrl
    }
    
    public var priceString: String {
        String(format: "%.2f", product.price)
    }
    
    public var description: String {
        product.description
    }
}
