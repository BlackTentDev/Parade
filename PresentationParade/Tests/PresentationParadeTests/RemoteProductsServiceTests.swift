//
//  RemoteFetchProductService.swift
//  
//
//  Created by Łukasz Szymczuk on 06/03/2023.
//

import XCTest
import PresentationParade

class RemoteProductsServiceTests: XCTestCase {
    func testOnInit_CreateService() throws {
        let sut = makeSUT()
        
        XCTAssertNotNil(sut)
    }

    
    func testFetch_Timeout() {
        let sut = makeSUT()
        let expectation = self.expectation(description: "Fetch should complete within timeout with success or error")
        let timeout = sut.timeoutInSeconds
        
        sut.fetch { result in
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
        
        sut.fetch { result in
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
        
        sut!.fetch { result in
            XCTFail("Request should be already cancelled.")
        }
        
        sut = nil
        
        sleep(timeout)
    }

    
    private func makeSUT() -> RemoteProductsService {
        return RemoteProductsService()
    }

}
