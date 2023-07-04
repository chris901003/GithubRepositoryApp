//
//  SharedInfo.swift
//  GithubRepositoryApp
//
//  Created by 黃弘諺 on 2023/7/4.
//

import Foundation

@MainActor
final class SharedInfo: ObservableObject {
    
    @Published var allRepo: [String] = []
    
    @Published var alertType: GitRepoAlertView.AlterType? = nil
    @Published var alertMessage: (any RawRepresentable & LocalizedError)? = nil
    
}
