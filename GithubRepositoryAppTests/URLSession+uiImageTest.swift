//
//  URLSession+uiImageTest.swift
//  GithubRepositoryAppTests
//
//  Created by 黃弘諺 on 2023/7/7.
//

import XCTest

class URLSessionUIImageTest: XCTestCase {
    func testSuccessRequestImage() async throws {
        let urlString: String = "https://avatars.githubusercontent.com/u/75870128?v=4"
        let url = URL(string: urlString)
        XCTAssertNotNil(url)
        guard let url = url else { fatalError() }
        let request = URLRequest(url: url)
        let session = URLSession.shared
        do {
            let _ = try await session.uiImage(request: request)
        } catch {
            XCTFail("不應該要失敗")
        }
    }
    
    func testConnotTransferToUIImage() async throws {
        let urlString: String = "https://google.com"
        let url = URL(string: urlString)
        XCTAssertNotNil(url)
        guard let url = url else { fatalError() }
        let request = URLRequest(url: url)
        let session = URLSession.shared
        do {
            let _ = try await session.uiImage(request: request)
            XCTFail("應該無法解析成圖像資料")
        } catch {
            guard let transferError = error as? URLSession.FetchImageError else {
                XCTFail("錯誤資訊轉換失敗")
                return
            }
            XCTAssertEqual(transferError.rawValue, "無法轉換成圖像資料")
        }
    }
}
