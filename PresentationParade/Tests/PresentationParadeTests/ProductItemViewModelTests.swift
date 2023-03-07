//
//  ProductItemViewModelTests.swift
//  
//
//  Created by Łukasz Szymczuk on 07/03/2023.
//

import XCTest
import PresentationParade
import CoreParade

class ProductItemViewModelTests: XCTestCase {

    func testPrice_ShouldDisplayOnly2DigitsAfterDecimalPoint() {
        let sut = makeSUT(with: 1.23)
        
        XCTAssert(sut.priceString == "1.23")
    }
    
    private func makeSUT(with price: Double) -> ProductItemViewModel {
        let product = Product(id: "", name: "", price: price, description: "", imageUrl: "")
        return ProductItemViewModel(product: product)
    }

}
