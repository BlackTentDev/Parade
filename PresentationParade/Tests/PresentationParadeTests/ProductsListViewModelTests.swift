//
//  ProductsListViewModel.swift
//  
//
//  Created by Łukasz Szymczuk on 07/03/2023.
//

import XCTest
import PresentationParade
import CoreParade
import Combine

class ProductsListViewModelTests: XCTestCase {
    let title: String = "kProducts".localized
    
    func testTitle_TitleShouldUseLocalizedTitle() {
        let sut = makeSUT()
        
        XCTAssertEqual(title, sut.title)
    }
    
    func testProducts_ShouldHaveProductsAfterSuccessfulFetch() {
        let numberOfProducts = 3
        let fetchService = FetchProductServiceMock(products: Product.listMock(size: numberOfProducts), action: .success)
        let sut = makeSUT(fetchService: fetchService)
        
        sut.getProducts()
        
        XCTAssertEqual(numberOfProducts, sut.products.count)
        
    }
    
    func testProducts_ShouldHaveEmptyArrayAfterFailedFetch() {
        let numberOfProducts = 3
        let fetchService = FetchProductServiceMock(products: Product.listMock(size: numberOfProducts), action: .fail)
        let sut = makeSUT(fetchService: fetchService)
        
        sut.getProducts()
        
        XCTAssert(sut.products.isEmpty)
    }
    
    func testProducts_ShouldHaveProductsAfterRefresh() {
        let numberOfProducts = 3
        let fetchService = FetchProductServiceMock(products: Product.listMock(size: numberOfProducts))
        let sut = makeSUT(fetchService: fetchService)
        
        //1. Get Products with failure
        fetchService.action = .fail
        sut.getProducts()
        XCTAssert(sut.products.isEmpty)
        
        //2. Now refresh with success
        fetchService.action = .success
        sut.refresh()
        
        XCTAssert(sut.products.count > 0)
    }

    private func makeSUT(fetchService: FetchProductService = FetchProductServiceMock(products: [])) -> ProductsListViewModel {
        ProductsListViewModel(fetchService: fetchService)
    }
    
}

private class FetchProductServiceMock: FetchProductService {
    private let products: [Product]
    var action: Action
    
    init(products: [Product], action: Action = .success) {
        self.products = products
        self.action = action
    }
    
    func fetch(completion: @escaping (Result<[CoreParade.Product], Error>) -> Void) {
        switch action {
        case .success:
            completion(.success(products))
            break
        case .fail:
            completion(.failure(NSError()))
            break
        }
    }
    
    enum Action {
        case fail, success
    }
}

