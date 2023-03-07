//
//  ProductsListViewModel.swift
//  
//
//  Created by Łukasz Szymczuk on 06/03/2023.
//

import Foundation
import CoreParade

public class ProductsListViewModel: ObservableObject {
    @Published public var products: [Product]
    @Published public var isLoading: Bool = false
    
    public let title: String = "kProducts".localized
    
    private let fetchService: FetchProductService
    
    public init(fetchService: FetchProductService) {
        self.fetchService = fetchService
        self.products = []
    }
    
    public func getProducts() {
        fetchProducts(skipCache: false)
    }
    
    //Skip Cache when refreshing data
    public func refresh() {
        fetchProducts(skipCache: true)
    }
    
    private func fetchProducts(skipCache: Bool) {
        isLoading = true
        fetchService.fetch(skipCache: skipCache) { [weak self] result in
            guard let self = self else {
                return
            }
            
            self.isLoading = false
            self.products = Self.mapFetchProducts(result: result)
        }
    }
    
    private static func mapFetchProducts(result: FetchProductService.Result) ->  [Product] {
        switch result {
            case let .success(products):
                return products
            case .failure:
                return []
        }
    }
}
