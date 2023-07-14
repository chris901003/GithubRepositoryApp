//
//  FollowUserDetailModel.swift
//  GithubRepositoryApp
//
//  Created by 黃弘諺 on 2023/7/11.
//

import Foundation
import SwiftUI

struct FollowUserDetailModel {
    // 使用者基本資料
    var basicInfo: UserFollowModel
    // 所有repo的資料
    var repos: [FollowUserRepo]
}

extension FollowUserDetailModel: Identifiable {
    // 提供ID
    var id: Int { basicInfo.id }
}

// MARK: FollowUserDetailModel Decodabe
extension FollowUserDetailModel: Decodable {
    init(from decoder: Decoder) throws {
        self.basicInfo = try UserFollowModel(from: decoder)
        self.repos = []
    }
}

extension FollowUserDetailModel {
    /// 獲取該使用者所擁有的倉庫資料
    mutating func fetchRepos() async throws {
        let urlRequest = URLRequest(url: self.basicInfo.reposURL)
        var repos = try await HttpRequestManager.shared.fetchData(urlRequest: urlRequest, dataType: [FollowUserRepo].self, session: .userSession)
        repos = repos.sorted(\.lastPushTime, decrease: true)
        self.repos = repos
    }
}

struct FollowUserRepo {
    // Ex: "html_url": "https://github.com/chris901003/chris901003"
    var repoURL: URL
    // Ex: "pushed_at": "2023-07-11T02:37:18Z"
    var lastPushTime: String
    // Ex: "language": "Swift"
    var mainLanguage: String
    // Ex: "name": "chris901003"
    var name: String
}

extension FollowUserRepo: Identifiable {
    var id: String { name }
}

extension FollowUserRepo {
    // 最後更新時間與當前時間間隔日
    var lastUpdatePassTime: Int {
        let lastUpdateTime = lastPushTime.convertToDate() ?? .now
        return Date.countDayPass(from: lastUpdateTime, to: .now)
    }
    // 根據最後更新到現在的間隔時間回傳一個顏色
    var updatePassTimeColor: Color {
        let dayPass: Int = lastUpdatePassTime
        switch dayPass {
            case 0...5:
                return Color.green
            case 6...15:
                return Color.orange
            case 16...:
                return Color.pink
            default:
                return Color.black
        }
    }
}

// MARK: FollowUserRepo Decodable
extension FollowUserRepo: Decodable {
    enum CodingKeys: String, CodingKey {
        case repoURL = "html_url"
        case lastPushTime = "pushed_at"
        case mainLanguage = "language"
        case name = "name"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.repoURL = try container.decode(String.self, forKey: .repoURL).toURL()!
        self.lastPushTime = try container.decode(String.self, forKey: .lastPushTime)
        self.mainLanguage = (try? container.decode(String.self, forKey: .mainLanguage)) ?? "Unknow"
        self.name = try container.decode(String.self, forKey: .name)
    }
}
