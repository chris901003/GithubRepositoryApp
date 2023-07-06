//
//  Collection+.swift
//  GithubRepositoryApp
//
//  Created by 黃弘諺 on 2023/7/6.
//

import Foundation

extension Collection {
    func targetIdx<Value: Comparable>(_ path: KeyPath<Element, Value>, target: Value) -> Self.Index? {
        firstIndex { $0[keyPath: path] == target }
    }
}
