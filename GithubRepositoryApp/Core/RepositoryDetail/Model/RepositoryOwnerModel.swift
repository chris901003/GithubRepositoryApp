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
    var photoLink: URL
    // Ex: "url": "https://api.github.com/users/chris901003"
    var githubLink: URL
    
    init(name: String, photoLink: URL, githubLink: URL) {
        self.name = name
        self.photoLink = photoLink
        self.githubLink = githubLink
    }
}

extension RepositoryOwnerModel: Decodable {
    enum CodingKeys: String, CodingKey {
        case name = "login"
        case photoLink = "avatar_url"
        case githubLink = "url"
    }
    
    init(from decoder: Decoder) throws {
        // 全部的URL都使用Force Unwrapped
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.photoLink = try container.decode(String.self, forKey: .photoLink).toURL()!
        self.githubLink = try container.decode(String.self, forKey: .githubLink).toURL()!
    }
}

// MARK: Mock Data
extension RepositoryOwnerModel {
    static func mock() -> Self {
        .init(name: "chris901003",
              photoLink: URL(string: "https://avatars.githubusercontent.com/u/75870128?v=4")!,
              githubLink: URL(string: "https://api.github.com/users/chris901003")!)
    }
}
