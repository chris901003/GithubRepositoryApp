//
//  OperationOverloading.swift
//  GithubRepositoryApp
//
//  Created by 黃弘諺 on 2023/7/5.
//

import Foundation

func == <Root, Value: Equatable>(lhs: KeyPath<Root, Value>, rhs: Value) -> (Root) -> Bool {
    { $0[keyPath: lhs] == rhs }
}

func < <Root, Value: Comparable>(lhs: KeyPath<Root, Value>, rhs: Value) -> (Root) -> Bool {
    { $0[keyPath: lhs] < rhs }
}
