//
//  UserDefaultManagerTest.swift
//  GithubRepositoryAppTests
//
//  Created by 黃弘諺 on 2023/7/10.
//

import XCTest

class UserDefaultManagerTest: XCTestCase {
    
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
}
