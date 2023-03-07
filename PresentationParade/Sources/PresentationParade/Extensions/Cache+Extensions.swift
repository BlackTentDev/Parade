//
//  File.swift
//  
//
//  Created by Łukasz Szymczuk on 07/03/2023.
//

import Foundation

extension URLCache {
    public static func configSharedCache(directory: String? = Bundle.main.bundleIdentifier, memory: Int = 1024*1024, disk: Int = 1024*1024) {
        URLCache.shared = {
            let cacheDirectory = (NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0] as String).appendingFormat("/\(directory ?? "cache")/" )
            return URLCache(memoryCapacity: memory, diskCapacity: disk, diskPath: cacheDirectory)
        }()
    }
}
