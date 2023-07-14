//
//  SingleUserWidgetProvider.swift
//  GithubRepositoryApp
//
//  Created by 黃弘諺 on 2023/7/14.
//

import WidgetKit

struct SingleUserWidgetProvider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SingleUserWidgeteEntry {
        .init(date: .now, viewInfo: .placeholder)
    }
    
    func getSnapshot(for configuration: SingleUserSelectIntent, in context: Context, completion: @escaping (SingleUserWidgeteEntry) -> Void) {
        completion(.init(date: .now, viewInfo: .snapshot))
    }
    
    func getTimeline(for configuration: SingleUserSelectIntent, in context: Context, completion: @escaping (Timeline<SingleUserWidgeteEntry>) -> Void) {
        Task {
            var entry: SingleUserWidgeteEntry = .init(date: .now, viewInfo: .placeholder)
            if let userName = configuration.User,
               userName != "Placeholder" {
                let url = "https://api.github.com/users/\(userName)".toURL()!
                let urlRequest = URLRequest(url: url)
                do {
                    var userInfo = try await HttpRequestManager.shared.fetchData(urlRequest: urlRequest, dataType: UserFollowModel.self, session: .userSession)
                    try await userInfo.fetchUserPhotoData()
                    var userDetailInfo: FollowUserDetailModel = .init(basicInfo: userInfo, repos: [])
                    try await userDetailInfo.fetchRepos()
                    userDetailInfo.repos = userDetailInfo.repos.myPrefix(2)
                    entry = .init(date: .now, viewInfo: .normal(userDetailInfo))
                } catch {
                    entry = .init(date: .now, viewInfo: .noInternet)
                }
            }
            let nextUpdateTime: Date = .now.addingTimeInterval(3600)
            let timeline = Timeline(entries: [entry], policy: .after(nextUpdateTime))
            completion(timeline)
        }
    }
}
