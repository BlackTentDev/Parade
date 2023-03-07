//
//  Any+Extensions.swift
//  
//
//  Created by Łukasz Szymczuk on 07/03/2023.
//

import Foundation
import CoreParade

extension Product {
    public static func listMock(size: Int) -> [Product] {
        (0...size-1).map {
            Product.mock(index: $0)
        }
    }
    
    public static func mock(index: Int) -> Product {
        Product(id: UUID().uuidString, name: "Product \(index)", price: 1.0, description: "Desc", imageUrl: String.dummyImageUrl)
    }
}
