//
//  Sequence+.swift
//  GithubRepositoryApp
//
//  Created by 黃弘諺 on 2023/7/5.
//

import Foundation

extension Sequence {
    func sorted<T: Comparable>(_ path: KeyPath<Element, T>, decrease: Bool = false) -> [Element] {
        sorted {
            decrease ? $0[keyPath: path] > $1[keyPath: path] : $0[keyPath: path] < $1[keyPath: path]
        }
    }
}
