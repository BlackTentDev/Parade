//
//  ParadeApp.swift
//  Parade
//
//  Created by Łukasz Szymczuk on 06/03/2023.
//

import SwiftUI
import PresentationParade

@main
struct ParadeApp: App {
    let fetchService: RemoteProductsService
    let productListViewModel: ProductsListViewModel
    
    init() {
        fetchService = RemoteProductsService()
        productListViewModel = ProductsListViewModel(fetchService: fetchService)
    }
    
    var body: some Scene {
        WindowGroup {
            ProductsListView(viewModel: productListViewModel)
        }
    }
}
