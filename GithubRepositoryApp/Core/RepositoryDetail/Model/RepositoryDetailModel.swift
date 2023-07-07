//
//  RepositoryDetailModel.swift
//  GithubRepositoryApp
//
//  Created by 黃弘諺 on 2023/7/6.
//

import Foundation

struct RepositoryDetailModel {
    // Ex: "full_name" = "chris901003/GithubRepositoryApp"
    var fullName: String
    // Ex: "owner": {}
    var owner: RepositoryOwnerModel
    // Ex: "html_url": "https://github.com/chris901003/GithubRepositoryApp"
    var repoLink: String
    // Ex: "languages_url": "https://api.github.com/repos/chris901003/GithubRepositoryApp/languages"
    var languagesUseLink: String
    // Ex: "pushed_at": "2023-07-06T04:01:32Z"
    var lastPushTime: String
    // Ex: "language": "Swift"
    var mainLanguage: String
    // 需要從languagesUseLink中進行網路獲取
    var languagesUse: [String: Int]
    
    init(fullName: String, owner: RepositoryOwnerModel, repoLink: String, languagesUseLink: String, lastPushTime: String, mainLanguage: String, languagesUse: [String: Int]) {
        self.fullName = fullName
        self.owner = owner
        self.repoLink = repoLink
        self.languagesUseLink = languagesUseLink
        self.lastPushTime = lastPushTime
        self.mainLanguage = mainLanguage
        self.languagesUse = languagesUse
    }
}

extension RepositoryDetailModel {
    static func mock() -> Self {
        .init(fullName: "chris901003/GithubRepositoryApp", owner: .mock(), repoLink: "https://github.com/chris901003/GithubRepositoryApp", languagesUseLink: "https://api.github.com/repos/chris901003/GithubRepositoryApp/languages", lastPushTime: "2023-07-06T04:01:32Z", mainLanguage: "Swift", languagesUse: ["Swift": 25337])
    }
}
