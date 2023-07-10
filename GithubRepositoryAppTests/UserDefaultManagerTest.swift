//
//  UserDefaultManagerTest.swift
//  GithubRepositoryAppTests
//
//  Created by 黃弘諺 on 2023/7/10.
//

import XCTest

class UserDefaultManagerTest: XCTestCase {
    
    /// 每次測試後清除所有UserDefault當中資料
    override func tearDown() {
        UserDefaultManager.shared.resetData()
    }
    
    /// 測試存放資料並且讀取資料
    func testSaveAndFetchData() {
        let repoData: String = "chris901003/GithubRepositoryApp"
        UserDefaultManager.shared.updateData(key: .repoList, data: [repoData])
        guard let repoList: [String] = UserDefaultManager.shared.fetchData(key: .repoList) else {
            XCTFail("無法解析")
            return
        }
        XCTAssertEqual(repoList[0], repoData)
    }
    
    /// 測試更新資料
    func testUpdateData() {
        var repoData: String = "chris901003/GithubRepositoryApp"
        UserDefaultManager.shared.updateData(key: .repoList, data: [repoData])
        repoData = "chris901003/DeepLearning"
        UserDefaultManager.shared.updateData(key: .repoList, data: [repoData])
        guard let repoList: [String] = UserDefaultManager.shared.fetchData(key: .repoList) else {
            XCTFail("無法解析")
            return
        }
        XCTAssertEqual(repoList[0], repoData)
    }
    
    /// 測試刪除所有資料
    func testRemoveAllData() {
        let repoData: String = "chris901003/GithubRepositoryApp"
        UserDefaultManager.shared.updateData(key: .repoList, data: [repoData])
        UserDefaultManager.shared.resetData()
        guard let _: [String] = UserDefaultManager.shared.fetchData(key: .repoList) else {
            return
        }
        XCTFail("應該無法解析，因為已經是空的")
    }
    
    /// 保存遵守Codable資料
    func testSaveCodableData() {
        let person: Person = .init(name: "Chris", age: 21, isMale: true)
        do {
            try UserDefaultManager.shared.updateDataCodable(key: .repoList, data: [person])
        } catch {
            XCTFail("發生錯誤: \(error)")
        }
    }
    
    /// 獲取保存資料遵守Codable
    func testSaveAndFetchCodableData() {
        testSaveCodableData()
        do {
            let fetchResult: [Person] = try UserDefaultManager.shared.fetchDataCodable(key: .repoList)
            print(fetchResult)
        } catch {
            XCTFail("無法獲取資料")
        }
    }
}

private extension UserDefaultManagerTest {
    struct Person: Codable {
        let name: String
        let age: Int
        let isMale: Bool
    }
}
