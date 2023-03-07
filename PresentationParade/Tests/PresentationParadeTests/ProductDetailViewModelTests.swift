//
//  ProductDetailViewModelTests.swift
//  
//
//  Created by Łukasz Szymczuk on 07/03/2023.
//

import XCTest
import PresentationParade
import CoreParade

class ProductDetailViewModelTests: XCTestCase {

    func testInit() {
        let product = Product(id: "", name: "Product", price: 1.23, description: "Desc", imageUrl: "url")
        let sut = makeSUT(with: product)
        
        XCTAssertEqual(sut.name, product.name)
        XCTAssertEqual(sut.description, product.description)
        XCTAssertEqual(sut.imageUrl, product.imageUrl)
    }
    
    func testPrice_ShouldDisplayOnly2DigitsAfterDecimalPoint() {
        let sut = makeSUT(with: 1.23)
        
        XCTAssert(sut.priceString == "1.23")
    }
    
    private func makeSUT(with price: Double) -> ProductDetailViewModel {
        let product = Product(id: "", name: "", price: price, description: "", imageUrl: "")
        return ProductDetailViewModel(product: product)
    }
    
    private func makeSUT(with product: Product) -> ProductDetailViewModel {
        return ProductDetailViewModel(product: product)
    }

}
