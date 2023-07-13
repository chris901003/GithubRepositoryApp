//
//  UserFollowModel.swift
//  GithubRepositoryApp
//
//  Created by 黃弘諺 on 2023/7/11.
//

import Foundation

struct UserFollowModel: Identifiable {
    // Ex: "id": 622781590
    var id: Int
    // Ex: "login": "chris901003"
    var user: String
    // Ex: "name": "HE_SE"
    var name: String
    // Ex: "avatar_url": "https://avatars.githubusercontent.com/u/75870128?v=4"
    var photoLink: URL
    // Ex: "followers": 1
    var followers: Int
    // Ex: "public_repos": 9
    var publicRepos: Int
    // Ex: "repos_url": "https://api.github.com/users/chris901003/repos"
    var reposURL: URL
    // 須透過phtoLink額外獲取
    var photoData: Data?
}

extension UserFollowModel: Decodable {
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case user = "login"
        case name = "name"
        case photoLink = "avatar_url"
        case followers = "followers"
        case publicRepos = "public_repos"
        case reposURL = "repos_url"
        case photoData = "photo_data"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.user = try container.decode(String.self, forKey: .user)
        self.name = try container.decode(String.self, forKey: .name)
        self.photoLink = try container.decode(String.self, forKey: .photoLink).toURL()!
        self.followers = try container.decode(Int.self, forKey: .followers)
        self.publicRepos = try container.decode(Int.self, forKey: .publicRepos)
        self.reposURL = try container.decode(String.self, forKey: .reposURL).toURL()!
        self.photoData = nil
    }
}

extension UserFollowModel: Encodable { }


// MARK: Mock Data
extension UserFollowModel {
    static func mock() -> UserFollowModel {
        .init(id: 622781590,user: "chris901003", name: "HE_SE", photoLink: "https://avatars.githubusercontent.com/u/75870128?v=4".toURL()!, followers: 1, publicRepos: 9, reposURL: "https://api.github.com/users/chris901003/repos".toURL()!)
    }
}
