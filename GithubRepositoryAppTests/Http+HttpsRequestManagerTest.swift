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
        let url: URL = "https://api.github.com/repos/chris901003/GithubRepositoryApp".toURL()!
        let urlRequest: URLRequest = .init(url: url)
        do {
            let repoInfo = try await HttpRequestManager.shared.fetchData(urlRequest: urlRequest, dataType: RepositoryDetailModel.self)
            print("✅ Success")
            print(repoInfo)
        } catch {
            XCTFail("❌ Fetch fail: \(error)")
        }
    }
    
    /// 在JsonPlaceholder上進行測試(測試通用性)
    func testOnJsonPlaceholder() async {
        let url = "https://jsonplaceholder.typicode.com/todos/1".toURL()!
        let urlRequest = URLRequest(url: url)
        do {
            let result = try await HttpRequestManager.shared.fetchData(urlRequest: urlRequest, dataType: JsonPlaceholderData1.self)
            print("✅ Success")
            print(result)
        } catch {
            XCTFail("❌ Fetch fail: \(error)")
        }
    }
    
    /// 測試給一個錯誤的解碼結構
    func testWrongDecodeType() async {
        let url = "https://jsonplaceholder.typicode.com/todos/1".toURL()!
        let urlRequest = URLRequest(url: url)
        do {
            let _ = try await HttpRequestManager.shared.fetchData(urlRequest: urlRequest, dataType: RepositoryDetailModel.self)
            XCTFail("應該解碼失敗，若跑到這裡請檢查是否有問題")
        } catch {
            guard let errorTransfer = error as? HttpRequestManager.FetchDataError else {
                XCTFail("應該要成功將error轉型")
                return
            }
            XCTAssertEqual(errorTransfer, HttpRequestManager.FetchDataError.decode)
        }
    }
    
    /// 測試給定一個特殊的狀態碼合法範圍
    func testStatusCode() async {
        let url = "https://jsonplaceholder.typicode.com/todos/1".toURL()!
        let urlRequest = URLRequest(url: url)
        do {
            // 這裡我設定的期望狀態碼範圍在[404~405]，但這裡會是200所以會正常來說會到catch中
            let _ = try await HttpRequestManager.shared.fetchData(urlRequest: urlRequest, dataType: JsonPlaceholderData1.self, statusCodeRange: 404...405)
            XCTFail("不應該到這裡")
        } catch {
            guard let errorTransfer = error as? HttpRequestManager.FetchDataError else {
                XCTFail("應該要成功將error轉型")
                return
            }
            XCTAssertEqual(errorTransfer, HttpRequestManager.FetchDataError.statusCode)
        }
    }
}

private extension HttpRequestManagerTest {
    
    // GET https://jsonplaceholder.typicode.com/todos/1
    struct JsonPlaceholderData1: Decodable {
        var userId: Int
        var id: Int
        var title: String
        var completed: Bool
    }
}
