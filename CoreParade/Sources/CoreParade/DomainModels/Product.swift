//
//  Product.swift
//  
//
//  Created by Łukasz Szymczuk on 06/03/2023.
//

import Foundation

public struct Product: Codable, Equatable {
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
}
