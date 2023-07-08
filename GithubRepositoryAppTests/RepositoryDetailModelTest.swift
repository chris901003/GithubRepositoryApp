//
//  RepositoryDetailModelTest.swift
//  GithubRepositoryAppTests
//
//  Created by 黃弘諺 on 2023/7/8.
//

import XCTest

class RepositoryDetailModelTest: XCTestCase {
    
    /// 測試獲取使用程式語言資料
    func testFetchLanguageUse() async {
        let url = "https://api.github.com/repos/chris901003/DeepLearning".toURL()!
        let urlRequest = URLRequest(url: url)
        guard var repoInfo = try? await HttpRequestManager.shared.fetchData(urlRequest: urlRequest, dataType: RepositoryDetailModel.self) else {
            XCTFail("無法獲取Repo資訊")
            return
        }
        await repoInfo.fetchLanguageUse()
        XCTAssertGreaterThan(repoInfo.languagesUse.count, 0)
    }
}
