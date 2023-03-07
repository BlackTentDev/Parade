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
    private var subscribers: Set<AnyCancellable> = []
    
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
    
    func testLoading_ShouldSetLoadingFlagOnlyWhenRequestIsOngoing() {
        let numberOfProducts = 3
        let fetchService = FetchProductServiceMock(products: Product.listMock(size: numberOfProducts))
        
        //Delay fetch request to catch flag
        fetchService.delay = 0.1
        let sut = makeSUT(fetchService: fetchService)
        
        XCTAssert(sut.isLoading == false)

        sut.getProducts()
        
        XCTAssert(sut.isLoading == true)
    }
    
    func testLoading_ShouldResetFlagWhenFinished() {
        let numberOfProducts = 3
        let fetchService = FetchProductServiceMock(products: Product.listMock(size: numberOfProducts))
        
        let sut = makeSUT(fetchService: fetchService)
        
        XCTAssert(sut.isLoading == false)

        sut.getProducts()
        
        //Mock service returns fetch immediately so flag should be false
        XCTAssert(sut.isLoading == false)
    }

    private func makeSUT(fetchService: FetchProductService = FetchProductServiceMock(products: [])) -> ProductsListViewModel {
        ProductsListViewModel(fetchService: fetchService)
    }
    
}

private class FetchProductServiceMock: FetchProductService {
    
    private let products: [Product]
    var delay: Double = 0.0    
    var action: Action
    
    init(products: [Product], action: Action = .success) {
        self.products = products
        self.action = action
    }
    
    func fetch(skipCache: Bool, completion: @escaping (FetchProductService.Result) -> Void) {
        var result: FetchProductService.Result
        
        switch self.action {
        case .success:
            result = .success(products)
            break
        case .fail:
            result = .failure(NSError())
            break
        }
        
        //If there is no delay continue synchronously
        if delay > 0.0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                completion(result)
            }
        } else {
            completion(result)
        }
        
    }
    
    enum Action {
        case fail, success
    }
}

