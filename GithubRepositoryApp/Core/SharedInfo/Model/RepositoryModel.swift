//
//  RepositoryModel.swift
//  GithubRepositoryApp
//
//  Created by 黃弘諺 on 2023/7/5.
//

import Foundation

struct RepositoryModel: Identifiable, Codable {
    var repoLink: String
    var isFavoriate: Bool = false
    
    var seperateLink: [String] { repoLink.components(separatedBy: "/") }
    var userName: String? { seperateLink.first }
    var repoName: String? { seperateLink.last }
    
    var id: String { repoLink }
}

extension RepositoryModel {
    static func mock() -> RepositoryModel {
        .init(repoLink: "chris901003/GithubRepositoryApp")
    }
}
