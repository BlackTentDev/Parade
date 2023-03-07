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
    private let baseUrl = URL(string: "https://run.mocky.io/v3/")!
    private let session = URLSession(configuration: .default)
    
    public let cache = URLCache.shared
    public let timeoutInSeconds = 10
    
    private var subscribers: Set<AnyCancellable> = []
    
    public init() {
        URLCache.configSharedCache()
    }
    
    // MARK: - Requests
    public func fetch(skipCache: Bool, completion: @escaping (FetchProductService.Result) -> Void) {
        let request = URLRequest(url: productEndpoint)
        
        //Check if we should use cache and return if response is present for request.
        if skipCache == false, let products = returnCache(for: request) {
            completion(.success(products))
            debugPrint("Returning Cached Verison")
            return
        }
        
        session.dataTaskPublisher(for: request)
            .timeout(.seconds(timeoutInSeconds), scheduler: DispatchQueue.main, options: nil)
            .sink(receiveCompletion: { subscriberCompletion in
                debugPrint(subscriberCompletion)
                
                switch subscriberCompletion {
                    case .finished:
                        break
                    case let .failure(error):
                        completion(.failure(error))
                }
                
            }, receiveValue: { [weak self] output in
                do {
                    let products = try Self.parseProductsResponse(data: output.data)
                    completion(.success(products))
                    debugPrint("Returning Live Version")
                    //Cache response
                    self?.storeResponse(output: output, request: request)
                } catch {
                    completion(.failure(error))
                }
            })
            .store(in: &subscribers)
    }
    
    private func returnCache(for request: URLRequest) -> [Product]? {
        guard let cachedResponse = cache.cachedResponse(for: request) else {
            return nil
        }
        
        do {
            return try Self.parseProductsResponse(data: cachedResponse.data)
        } catch {
            //Remove Cache with corrupted data and continue
            cache.removeCachedResponse(for: request)
            return nil
        }
    }
    
    typealias FetchOutput = (data: Data, response: URLResponse)
    
    private func storeResponse(output: FetchOutput, request: URLRequest) {
        let cachedResponse = CachedURLResponse(response: output.response, data: output.data)
        cache.storeCachedResponse(cachedResponse, for: request)
    }
    
    private static func parseProductsResponse(data: Data) throws -> [Product] {
        try JSONDecoder().decode([Product].self, from: data)
    }
}


extension RemoteProductsService {
    public var productEndpoint: URL {
        baseUrl.appendingPathComponent(Endpoint.products.path())
    }
}
