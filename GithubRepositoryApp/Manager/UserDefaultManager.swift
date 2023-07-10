//
//  UserDefaultManager.swift
//  GithubRepositoryApp
//
//  Created by 黃弘諺 on 2023/7/10.
//

import Foundation

class UserDefaultManager {
    
    // Singleton
    static let shared: UserDefaultManager = UserDefaultManager()
    
    // Private Init Function
    private init() { }
    
    // Private Variable
    private let userDefaults: UserDefaults = UserDefaults(suiteName: "group.com.hungyen.GithubRepositoryApp")!
}

// MARK: Public Function
extension UserDefaultManager {
    /// 更新UserDefault當中資料
    func updateData<T>(key: UserDefaultKey, data: T) {
        userDefaults.set(data, forKey: key.rawValue)
    }
    
    /// 獲取UserDefault當中資料
    func fetchData<T>(key: UserDefaultKey) -> T? {
        return userDefaults.value(forKey: key.rawValue) as? T
    }
    
    /// 清空UserDefault當中所有資料
    func resetData() {
        UserDefaultKey.allCases.forEach { userDefaults.removeObject(forKey: $0.rawValue) }
    }
}

// MARK: All UserDefault Save Key
extension UserDefaultManager {
    enum UserDefaultKey: String, CaseIterable {
        case repoList = "RepoList"
    }
}
