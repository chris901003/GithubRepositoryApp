//
//  RepositoryOwnerModel.swift
//  GithubRepositoryApp
//
//  Created by 黃弘諺 on 2023/7/6.
//

import Foundation

struct RepositoryOwnerModel {
    // Ex: "login": "chris901003"
    var name: String
    // Ex: "avatar_url": "https://avatars.githubusercontent.com/u/75870128?v=4"
    var photoLink: String
    // Ex: "url": "https://api.github.com/users/chris901003"
    var githubLink: String
    
    init(name: String, photoLink: String, githubLink: String) {
        self.name = name
        self.photoLink = photoLink
        self.githubLink = githubLink
    }
}

extension RepositoryOwnerModel {
    static func mock() -> Self {
        .init(name: "chris901003", photoLink: "https://avatars.githubusercontent.com/u/75870128?v=4", githubLink: "https://api.github.com/users/chris901003")
    }
}
