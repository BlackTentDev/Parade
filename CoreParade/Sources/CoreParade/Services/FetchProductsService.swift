//
//  FetchProductService.swift
//  
//
//  Created by Łukasz Szymczuk on 06/03/2023.
//

import Foundation

public protocol FetchProductService {
    typealias Result = Swift.Result<[Product], Swift.Error>
    func fetch(completion: @escaping (FetchProductService.Result) -> Void)
}
