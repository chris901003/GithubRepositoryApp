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
    @Published var allFollowUser: [UserFollowModel] = []
    
    @Published var alertType: GitRepoAlertView.AlterType? = nil
    @Published var alertMessage: (any RawRepresentable & LocalizedError)? = nil
    
    init() {
        do {
            self.allRepo = try fetchAllRepo(key: .repoList)
        } catch { }
    }
}

// MARK: 公開的函數
extension SharedInfo {
    /// 設定顯示提醒必要資訊
    func changeAlertStatus(type: GitRepoAlertView.AlterType, message: (any RawRepresentable & LocalizedError)) {
        self.alertMessage = message
        self.alertType = type
    }
    
    /// 獲取以保存的倉庫資料
    func fetchAllRepo<T: Codable>(key: UserDefaultManager.UserDefaultKey) throws -> [T] {
        try UserDefaultManager.shared.fetchDataCodable(key: key)
    }
    
    /// 將當前的倉庫資料保存到UserDefault當中
    func saveAllRepo<T: Codable>(key: UserDefaultManager.UserDefaultKey, data: [T]) throws {
        try UserDefaultManager.shared.updateDataCodable(key: key, data: data)
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
        result.allFollowUser.append(.mock())
        return result
    }
}

extension SharedInfo {
    func removeAlert() {
        alertType = nil
        alertMessage = nil
    }
}
