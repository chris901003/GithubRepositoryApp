//
//  SingleRepoProvider.swift
//  GithubRepositoryWidgetExtension
//
//  Created by 黃弘諺 on 2023/7/10.
//

import WidgetKit

struct SingleRepoWidgetProvider: TimelineProvider {
    func placeholder(in context: Context) -> SingleRepoWidgetEntry {
        .init(date: .now, singleRepoView: .placeHolder)
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SingleRepoWidgetEntry) -> Void) {
        completion(.init(date: .now, singleRepoView: .snapshot))
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<SingleRepoWidgetEntry>) -> Void) {
        Task {
            do {
                let repoDetailInfo = try await fetchRepoDetail(repoLink: "chris901003/DeepLearning")
                let entry = SingleRepoWidgetEntry(date: .now, singleRepoView: .repoInfo(repoDetailInfo))
                let timeline = Timeline(entries: [entry], policy: .never)
                completion(timeline)
            } catch {
                let entry = SingleRepoWidgetEntry(date: .now, singleRepoView: .noInternet)
                let timeline = Timeline(entries: [entry], policy: .never)
                completion(timeline)
            }
        }
    }
}

private extension SingleRepoWidgetProvider {
    /// 獲取詳細倉庫資料
    func fetchRepoDetail(repoLink: String) async throws -> RepositoryDetailModel {
        let url = "https://api.github.com/repos/\(repoLink)".toURL()!
        let urlRequest = URLRequest(url: url)
        var repoInfo = try await HttpRequestManager.shared.fetchData(urlRequest: urlRequest, dataType: RepositoryDetailModel.self, session: .repoSession)
        await repoInfo.fetchLanguageUse()
        return repoInfo
    }
}
