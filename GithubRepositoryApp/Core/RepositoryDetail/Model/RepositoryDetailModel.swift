//
//  RepositoryDetailModel.swift
//  GithubRepositoryApp
//
//  Created by 黃弘諺 on 2023/7/6.
//

import Foundation
import SwiftUI

struct RepositoryDetailModel {
    // Ex: "full_name" = "chris901003/GithubRepositoryApp"
    var fullName: String
    // Ex: "owner": {}
    var owner: RepositoryOwnerModel
    // Ex: "html_url": "https://github.com/chris901003/GithubRepositoryApp"
    var repoLink: URL
    // Ex: "languages_url": "https://api.github.com/repos/chris901003/GithubRepositoryApp/languages"
    var languagesUseLink: URL
    // Ex: "pushed_at": "2023-07-06T04:01:32Z"
    var lastPushTime: String
    // Ex: "language": "Swift"
    var mainLanguage: String
    // Ex: "stargazers_count": 1
    var stars: Int
    // Ex: "stargazers_count": 1
    var forks: Int
    // Ex: "open_issues": 0
    var issues: Int
    // 需要從languagesUseLink中進行網路獲取
    var languagesUse: [(name: String, lines: Int)]
    
    init(fullName: String, owner: RepositoryOwnerModel, repoLink: URL, languagesUseLink: URL, lastPushTime: String, mainLanguage: String, stars: Int, forks: Int, issues: Int, languagesUse: [(String, Int)]) {
        self.fullName = fullName
        self.owner = owner
        self.repoLink = repoLink
        self.languagesUseLink = languagesUseLink
        self.lastPushTime = lastPushTime
        self.mainLanguage = mainLanguage
        self.stars = stars
        self.forks = forks
        self.issues = issues
        self.languagesUse = languagesUse
    }
}

extension RepositoryDetailModel {
    // 倉庫名稱
    var repoName: String { fullName.components(separatedBy: "/")[1] }
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

// MARK: Mock Init Function
extension RepositoryDetailModel {
    static func mock() -> Self {
        .init(fullName: "chris901003/GithubRepositoryApp",
              owner: .mock(),
              repoLink: URL(string: "https://github.com/chris901003/GithubRepositoryApp")!,
              languagesUseLink: URL(string: "https://api.github.com/repos/chris901003/GithubRepositoryApp/languages")!,
              lastPushTime: "2023-07-06T04:01:32Z",
              mainLanguage: "Swift",
              stars: 20,
              forks: 0,
              issues: 2,
              languagesUse: [("Swift", 25337), ("C++", 1201)])
    }
}
