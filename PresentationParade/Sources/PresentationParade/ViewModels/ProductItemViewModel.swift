//
//  File.swift
//  
//
//  Created by Łukasz Szymczuk on 07/03/2023.
//

import Foundation
import CoreParade

public struct ProductItemViewModel {
    public let name: String
    public let imageUrl: String
    
    private let price: Double
    
    public var priceString: String {
        String(format: "%.2f", price)
    }
    
    public init(product: Product) {
        self.name = product.name
        self.price = product.price
        self.imageUrl = product.imageUrl
    }
}
