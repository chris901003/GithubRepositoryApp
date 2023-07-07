//
//  Http+HttpsRequestManagerTest.swift
//  GithubRepositoryAppTests
//
//  Created by 黃弘諺 on 2023/7/7.
//

import XCTest

class HttpRequestManagerTest: XCTestCase {
    
    /// 測試是否可以獲取Repo資料
    func testFetchData() async {
        let urlString: String = "https://api.github.com/repos/chris901003/GithubRepositoryApp"
        let url: URL = URL(string: urlString)!
        let urlRequest: URLRequest = .init(url: url)
        do {
            let repoInfo = try await HttpRequestManager.shared.fetchData(urlRequest: urlRequest, dataType: RepositoryDetailModel.self)
            print("✅ Success")
            print(repoInfo)
        } catch {
            XCTFail("❌ Fetch fail: \(error)")
        }
    }
}
