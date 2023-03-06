//
//  File.swift
//  
//
//  Created by Łukasz Szymczuk on 06/03/2023.
//

import Foundation
import CoreParade
import Combine

fileprivate enum Endpoint: String {
    case products
    
    func path() -> String {
        switch self {
        case .products:
            return "1c4cfa98-e329-4d49-8836-8ee195cec131"
        }
    }
}

public class RemoteProductsService: FetchProductService {
    public init() {}
    
    private let baseUrl = URL(string: "https://run.mocky.io/v3/")!
    private let session = URLSession(configuration: .default)
    
    public let timeoutInSeconds = 10
    
    private var subscribers: Set<AnyCancellable> = []
    
    // MARK: - Requests
    public func fetch(completion: @escaping (FetchProductService.Result) -> Void) {
        let request = URLRequest(url: productEndpoint)
        
        session.dataTaskPublisher(for: request)
            .timeout(.seconds(timeoutInSeconds), scheduler: DispatchQueue.main, options: nil)
            .tryMap { output in
                try JSONDecoder().decode([Product].self, from: output.data)
            }
            .sink(receiveCompletion: { subscriberCompletion in
                debugPrint(subscriberCompletion)
                
                switch subscriberCompletion {
                    case .finished:
                        break
                    case let .failure(error):
                        completion(.failure(error))
                }
                
            }, receiveValue: { products in
                DispatchQueue.main.async {
                    completion(.success(products))
                }
            })
            .store(in: &subscribers)
    }
}


extension RemoteProductsService {
    var productEndpoint: URL {
        baseUrl.appendingPathComponent(Endpoint.products.path())
    }
}
