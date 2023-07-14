//
//  UserFollowModelTest.swift
//  GithubRepositoryAppTests
//
//  Created by 黃弘諺 on 2023/7/11.
//

import XCTest

class UserFollowModelTest: XCTestCase {
    
    func testFetchDataFromInternet() async {
        let url = "https://api.github.com/users/chris901003".toURL()!
        let urlRequest = URLRequest(url: url)
        do {
            let userInfo = try await HttpRequestManager.shared.fetchData(urlRequest: urlRequest, dataType: UserFollowModel.self, session: .userSession)
            print("✅ Fetch Success")
            print(userInfo)
        } catch {
            XCTFail("無法解析資料")
        }
    }
    
    /// 獲取圖像資料，並且轉成Data格式保存
    func testFetchUserPhotoData() async {
        let url = "https://api.github.com/users/chris901003".toURL()!
        let urlRequest = URLRequest(url: url)
        do {
            var userInfo = try await HttpRequestManager.shared.fetchData(urlRequest: urlRequest, dataType: UserFollowModel.self, session: .userSession)
            try await userInfo.fetchUserPhotoData()
            if let imageData = userInfo.photoData,
               let _ = UIImage(data: imageData) {
                print("✅ Fetch Success")
            }
        } catch {
            XCTFail("無法獲取圖像資料")
        }
    }
}
