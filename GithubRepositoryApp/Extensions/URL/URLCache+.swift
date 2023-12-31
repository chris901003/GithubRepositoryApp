//
//  URLCache+.swift
//  GithubRepositoryApp
//
//  Created by 黃弘諺 on 2023/7/7.
//

import Foundation

extension URLCache {
    static let imageCache: URLCache = {
        .init(memoryCapacity: 20 * 1024 * 1024,
              diskCapacity: 30 * 1024 * 1024)
    }()
    
    static let repoInfoCache: URLCache = {
        .init(memoryCapacity: 0 * 1024 * 1024,
              diskCapacity: 0 * 1024 * 1024)
    }()
    
    static let userInfoCache: URLCache = {
        .init(memoryCapacity: 0 * 1024 * 1024,
              diskCapacity: 0 * 1024 * 1024)
    }()
}
