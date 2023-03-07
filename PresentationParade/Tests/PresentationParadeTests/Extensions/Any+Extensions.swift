//
//  Any+Extensions.swift
//  
//
//  Created by Łukasz Szymczuk on 07/03/2023.
//

import Foundation
import CoreParade

extension Product {
    static func listMock(size: Int) -> [Product] {
        (0...size-1).map {
            Product(id: UUID().uuidString, name: "Product \($0)", price: 1.0, description: "Desc", imageUrl: "https://fastly.picsum.photos/id/1001/600/400.jpg?hmac=f1OC0DdGbWCIyD1b1Ey4LSXb311Ahcqqu1j52WyMHBs")
        }
    }
}
