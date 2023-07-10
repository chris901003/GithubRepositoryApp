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

// MARK: 公開的函數
extension SharedInfo {
    /// 獲取以保存的倉庫資料
    func fetchAllRepo() throws {
        self.allRepo = try UserDefaultManager.shared.fetchDataCodable(key: .repoList)
    }
    
    /// 將當前的倉庫資料保存到UserDefault當中
    func saveAllRepo() throws {
        try UserDefaultManager.shared.updateDataCodable(key: .repoList, data: allRepo)
    }
}

// MARK: Mock Init
extension SharedInfo {
    static func mockDataInit(repos: Int = 10) -> SharedInfo {
        let result: SharedInfo = SharedInfo()
        result.allRepo.append(.init(repoLink: "chris901003/GithubRepositoryApp"))
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
