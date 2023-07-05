//
//  SharedInfo.swift
//  GithubRepositoryApp
//
//  Created by 黃弘諺 on 2023/7/4.
//

import Foundation

@MainActor
final class SharedInfo: ObservableObject {
    
    @Published var allRepo: [RepositoryModel] = []
    
    @Published var alertType: GitRepoAlertView.AlterType? = nil
    @Published var alertMessage: (any RawRepresentable & LocalizedError)? = nil
}

// MARK: Mock Init
extension SharedInfo {
    static func mockDataInit(repos: Int = 10) -> SharedInfo {
        let result: SharedInfo = SharedInfo()
        for _ in 0..<repos {
            result.allRepo.append(.init(repoLink: String.randomString(length: 10)! + "/" + String.randomString(length: 10)!))
        }
        return result
    }
}

extension SharedInfo {
    func removeAlert() {
        alertType = nil
        alertMessage = nil
    }
}
