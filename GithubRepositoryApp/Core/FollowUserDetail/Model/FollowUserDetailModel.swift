//
//  FollowUserDetailModel.swift
//  GithubRepositoryApp
//
//  Created by 黃弘諺 on 2023/7/11.
//

import Foundation

struct FollowUserDetailModel: Identifiable {
    // 使用者基本資料
    var basicInfo: UserFollowModel
    // 提供ID
    var id: Int { basicInfo.id }
    // 所有repo的資料
    var repos: [FollowUserRepo]
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
        self.repos = try await HttpRequestManager.shared.fetchData(urlRequest: urlRequest, dataType: [FollowUserRepo].self, session: .userSession)
    }
}

struct FollowUserRepo {
    // Ex: "html_url": "https://github.com/chris901003/chris901003"
    var repoURL: URL
    // Ex: "pushed_at": "2023-07-11T02:37:18Z"
    var lastPushTime: String
    // Ex: "language": "Swift"
    var mainLanguage: String
}

// MARK: FollowUserRepo Decodable
extension FollowUserRepo: Decodable {
    enum CodingKeys: String, CodingKey {
        case repoURL = "html_url"
        case lastPushTime = "pushed_at"
        case mainLanguage = "language"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.repoURL = try container.decode(String.self, forKey: .repoURL).toURL()!
        self.lastPushTime = try container.decode(String.self, forKey: .lastPushTime)
        self.mainLanguage = (try? container.decode(String.self, forKey: .mainLanguage)) ?? "Unknow"
    }
}
