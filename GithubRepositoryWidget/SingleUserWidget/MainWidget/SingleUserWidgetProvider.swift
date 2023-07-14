//
//  SingleUserWidgetProvider.swift
//  GithubRepositoryApp
//
//  Created by 黃弘諺 on 2023/7/14.
//

import WidgetKit

struct SingleUserWidgetProvider: TimelineProvider {
    func placeholder(in context: Context) -> SingleUserWidgeteEntry {
        .init(date: .now, viewInfo: .placeholder)
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SingleUserWidgeteEntry) -> Void) {
        completion(.init(date: .now, viewInfo: .snapshot))
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<SingleUserWidgeteEntry>) -> Void) {
        do {
            let followUser: [UserFollowModel] = try UserDefaultManager.shared.fetchDataCodable(key: .userList)
            let entry = SingleUserWidgeteEntry(date: .now,
                                               viewInfo: .normal(.init(basicInfo: followUser.first!,
                                                                       repos: [.init(repoURL: "https://github.com/chris901003/DeepLearning".toURL()!,
                                                                                     lastPushTime: "2023-06-09T06:07:39Z",
                                                                                     mainLanguage: "Swift",
                                                                                     name: "DeepLearning"),
                                                                               .init(repoURL: "https://github.com/chris901003/DeepLearning".toURL()!,
                                                                                             lastPushTime: "2023-06-09T06:07:39Z",
                                                                                             mainLanguage: "Swift",
                                                                                             name: "DeepLearning")])))
            let timeline = Timeline(entries: [entry], policy: .never)
            completion(timeline)
        } catch {
            let entry = SingleUserWidgeteEntry(date: .now, viewInfo: .noInternet)
            let timeline = Timeline(entries: [entry], policy: .never)
            completion(timeline)
        }
    }
}
