//
//  FollowUserDetailModelTest.swift
//  GithubRepositoryAppTests
//
//  Created by 黃弘諺 on 2023/7/13.
//

import XCTest

class FollowUserDetailModelTest: XCTestCase {
    
    /// 測試從網路獲取資料
    func testFollowUserDetailModelInfoFetch() async {
        let url = "https://api.github.com/users/chris901003".toURL()!
        let urlRequest = URLRequest(url: url)
        do {
            let userInfo = try await HttpRequestManager.shared.fetchData(urlRequest: urlRequest, dataType: FollowUserDetailModel.self, session: .userSession)
            print("✅ Fetch Success: \(userInfo)")
        } catch {
            XCTFail("無法獲取資料")
        }
    }
    
    /// 測試使用者資料當中的repo資料是否可以正常解碼
    func testUserReposFetch() async {
        let url = "https://api.github.com/users/chris901003/repos".toURL()!
        let urlRequest = URLRequest(url: url)
        do {
            let reposInfo = try await HttpRequestManager.shared.fetchData(urlRequest: urlRequest, dataType: [FollowUserRepo].self, session: .userSession)
            print("✅ Fetch Success: \(reposInfo)")
        } catch {
            XCTFail("無法獲取資料")
        }
    }
    
    /// 獲取完整使用者資料
    func testFetchFullUserDetailInfo() async {
        let url = "https://api.github.com/users/chris901003".toURL()!
        let urlRequest = URLRequest(url: url)
        do {
            var userInfo = try await HttpRequestManager.shared.fetchData(urlRequest: urlRequest, dataType: FollowUserDetailModel.self, session: .userSession)
            try await userInfo.fetchRepos()
            print("✅ Fetch Success: \(userInfo)")
        } catch {
            XCTFail("無法獲取資料")
        }
    }
}
