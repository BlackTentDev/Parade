//
//  ProductsListView.swift
//  Parade
//
//  Created by Łukasz Szymczuk on 06/03/2023.
//

import SwiftUI
import PresentationParade
import CoreParade

struct ProductsListView: View {
    @ObservedObject var viewModel: ProductsListViewModel
    
    var body: some View {
        NavigationView {
            List(viewModel.products, id: \.self) { product in
                NavigationLink(destination: detailView(for: product), label: {
                    ProductListItemView(name: product.name, price: product.price, imageUrl: product.imageUrl)
                })
            }
            .animation(.easeInOut, value: viewModel.products)
            .navigationBarTitle(viewModel.title)
            .onAppear {
                viewModel.getProducts()
            }
        }
    }
    
    private func detailView(for product: Product) -> some View {
        ProductDetailView()
    }
}

struct ProductsListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductsListView(viewModel: ProductsListViewModel(fetchService: MockPreviewService()))
    }
}

private class MockPreviewService: FetchProductService {
    private let products = Product.listMock(size: 15)
    func fetch(completion: @escaping (Result<[CoreParade.Product], Error>) -> Void) {
        completion(.success(products))
    }
    
    
}