//
//  RemoteFetchProductService.swift
//  
//
//  Created by Łukasz Szymczuk on 06/03/2023.
//

import XCTest
import PresentationParade
import CoreParade

class RemoteProductsServiceTests: XCTestCase {
    func testOnInit_CreateService() throws {
        let sut = makeSUT()
        
        XCTAssertNotNil(sut)
    }

    
    func testFetch_Timeout() {
        let sut = makeSUT()
        let expectation = self.expectation(description: "Fetch should complete within timeout with success or error")
        let timeout = sut.timeoutInSeconds
        
        sut.fetch(skipCache: true) { result in
            switch result {
                default:
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: TimeInterval(timeout), handler: nil)
    }
    
    func testFetch_GetSomeNonNilProducts() {
        let sut = makeSUT()
        let expectation = self.expectation(description: "Fetch should complete within timeout with compatible data.")
        let timeout = sut.timeoutInSeconds
        
        sut.fetch(skipCache: true) { result in
            switch result {
                case .success(let products):
                    XCTAssertFalse(products.isEmpty, "Products array should not be empty")
                    expectation.fulfill()
                case .failure(let error):
                    XCTFail("Fetch failed with error: \(error.localizedDescription)")
            }
        }
        
        waitForExpectations(timeout: TimeInterval(timeout), handler: nil)
    }
    
    func testFetch_RequestIsCancelledWhenServiceIsDeallocated() {
        var sut: RemoteProductsService? = makeSUT()
        let timeout = UInt32(sut!.timeoutInSeconds)
        
        sut!.fetch(skipCache: true) { result in
            XCTFail("Request should be already cancelled.")
        }
        
        sut = nil
        
        sleep(timeout)
    }
    
    func testCache_CallShouldReturnedCachedVersion() {
        let sut = makeSUT()
        let expectation = self.expectation(description: "Fetch should complete within timeout with cached sample data.")
    
        let cache = sut.cache
        cache.removeAllCachedResponses()
        
        let url = sut.productEndpoint
        let request = URLRequest(url: url)
        let testProducts = [Product.mock(index: 0)]
        let cachedResponse = mockCachedResponse(with: testProducts, request: request)
        
        cache.storeCachedResponse(cachedResponse, for: request)
        
        sut.fetch(skipCache: false) { result in
            switch result {
                case .success(let products):
                XCTAssertEqual(products, testProducts)
                    expectation.fulfill()
                case .failure(let error):
                    XCTFail("Fetch failed with error: \(error.localizedDescription)")
            }
        }
        
        waitForExpectations(timeout: TimeInterval(sut.timeoutInSeconds), handler: nil)
    }
    
    func testCacheSkip_CallShouldReturnedDifferentResponseThanCached() {
        let sut = makeSUT()
        let expectation = self.expectation(description: "Fetch should complete within timeout with different data than cached.")
    
        let cache = sut.cache
        cache.removeAllCachedResponses()
        
        let url = sut.productEndpoint
        let request = URLRequest(url: url)
        let testProducts = [Product.mock(index: 0)]
        let cachedResponse = mockCachedResponse(with: testProducts, request: request)
        
        cache.storeCachedResponse(cachedResponse, for: request)
        
        sut.fetch(skipCache: true) { result in
            switch result {
                case .success(let products):
                
                XCTAssert(products.count > 1)
                
                XCTAssertNotEqual(products, testProducts)
                
                expectation.fulfill()
                
                case .failure(let error):
                    XCTFail("Fetch failed with error: \(error.localizedDescription)")
            }
        }
        
        waitForExpectations(timeout: TimeInterval(sut.timeoutInSeconds), handler: nil)
    }

    
    private func makeSUT() -> RemoteProductsService {
        return RemoteProductsService()
    }

    private func mockCachedResponse(with products: [Product], request: URLRequest) -> CachedURLResponse {
        let mockResponse = HTTPURLResponse(
            url: request.url!,
                statusCode: 200,
                httpVersion: "HTTP/1.1",
                headerFields: nil)!
        
        let sampleData = try! JSONEncoder().encode(products)
        
        return CachedURLResponse(
                response: mockResponse,
                data: sampleData)
        
    }
}
