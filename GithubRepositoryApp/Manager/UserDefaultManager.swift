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
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
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
    
    /// 保存遵守Codable資料，主要處理struct類型的保存
    func updateDataCodable<T: Codable>(key: UserDefaultKey, data: [T]) throws {
        do {
            let datas = try data.map { (info) throws in
                try encoder.encode(info)
            }
            updateData(key: key, data: datas)
        } catch {
            throw CodableDataError.decodeFail
        }
    }
    
    /// 獲取遵守Codable資料，主要是處理struct類型
    func fetchDataCodable<T: Codable>(key: UserDefaultKey) throws -> [T] {
        guard let datas = userDefaults.value(forKey: key.rawValue) as? [Data] else {
            throw CodableDataError.transformDataFail
        }
        do {
            let result = try datas.map { data throws in
                try decoder.decode(T.self, from: data)
            }
            return result
        } catch {
            throw CodableDataError.transformDataFail
        }
    }
}

extension UserDefaultManager {
    enum CodableDataError: String, LocalizedError {
        case decodeFail = "無法編碼"
        case transformDataFail = "無法獲取資料"
    }
}

// MARK: All UserDefault Save Key
extension UserDefaultManager {
    enum UserDefaultKey: String, CaseIterable {
        case repoList = "RepoList"
        case userList = "UserList"
    }
}
