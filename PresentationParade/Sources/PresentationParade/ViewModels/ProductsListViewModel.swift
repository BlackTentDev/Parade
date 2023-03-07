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
    
    public let title: String = "kProducts".localized
    
    private let fetchService: FetchProductService
    
    public init(fetchService: FetchProductService) {
        self.fetchService = fetchService
        self.products = []
    }
    
    public func getProducts() {
        fetchService.fetch { [weak self] result in
            guard let self = self else {
                return
            }
            
            self.products = Self.mapFetchProducts(result: result)
        }
    }
    
    public func refresh() {
        getProducts()
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
