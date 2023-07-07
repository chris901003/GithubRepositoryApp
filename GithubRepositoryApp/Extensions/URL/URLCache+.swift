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
}
