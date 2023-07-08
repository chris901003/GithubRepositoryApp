//
//  ModifyInStruct.swift
//  GithubRepositoryApp
//
//  Created by 黃弘諺 on 2023/7/8.
//

import SwiftUI

@propertyWrapper class ModifyInStruct<T> {
    var wrappedValue: T
    var projectedValue: T {
        get { wrappedValue }
        set { wrappedValue = newValue }
    }
    init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
    }
}
