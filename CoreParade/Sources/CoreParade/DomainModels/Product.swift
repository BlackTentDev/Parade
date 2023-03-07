//
//  Product.swift
//  
//
//  Created by Łukasz Szymczuk on 06/03/2023.
//

import Foundation

public struct Product: Codable, Equatable, Hashable {
    public let id: String
    public let name: String
    public let price: Double
    public let description: String
    public let imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case price
        case description
        case imageUrl = "image_url"
    }
    
    public init(id: String, name: String, price: Double, description: String, imageUrl: String) {
        self.id = id
        self.name = name
        self.price = price
        self.description = description
        self.imageUrl = imageUrl
    }
}
