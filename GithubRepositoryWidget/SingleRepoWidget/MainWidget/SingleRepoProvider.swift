//
//  SingleRepoProvider.swift
//  GithubRepositoryWidgetExtension
//
//  Created by 黃弘諺 on 2023/7/10.
//

import WidgetKit

struct SingleRepoWidgetProvider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SingleRepoWidgetEntry {
        .init(date: .now, singleRepoView: .placeHolder)
    }
    
    func getSnapshot(for configuration: SingleRepoSelectIntent, in context: Context, completion: @escaping (SingleRepoWidgetEntry) -> Void) {
        completion(.init(date: .now, singleRepoView: .snapshot))
    }
    
    func getTimeline(for configuration: SingleRepoSelectIntent, in context: Context, completion: @escaping (Timeline<SingleRepoWidgetEntry>) -> Void) {
        Task {
            var entry: SingleRepoWidgetEntry? = nil
            if let repoInfo = configuration.Repository {
                let repoType = SingleRepoWidgetSelection(rawValue: repoInfo)
                switch repoType {
                    case .placeholder:
                        entry = SingleRepoWidgetEntry(date: .now, singleRepoView: .placeHolder)
                    case .normalRepo(let repoLink):
                        do {
                            let repoDetailInfo = try await fetchRepoDetail(repoLink: repoLink)
                            entry = SingleRepoWidgetEntry(date: .now, singleRepoView: .repoInfo(repoDetailInfo))
                        } catch {
                            entry = SingleRepoWidgetEntry(date: .now, singleRepoView: .noInternet)
                        }
                }
            } else {
                entry = SingleRepoWidgetEntry(date: .now, singleRepoView: .placeHolder)
            }
            let nextUpdateTime: Date = .now.addingTimeInterval(3600)
            let timeline = Timeline(entries: [entry!], policy: .after(nextUpdateTime))
            completion(timeline)
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

extension SingleRepoWidgetProvider {
    enum SingleRepoWidgetSelection: RawRepresentable {
        init(rawValue: String) {
            switch rawValue {
                case "Placeholder":
                    self = .placeholder
                default:
                    self = .normalRepo(rawValue)
            }
        }
        
        var rawValue: String {
            switch self {
                case .placeholder:
                    return "Placeholder"
                case .normalRepo(let repoLink):
                    return repoLink
            }
        }
        
        case normalRepo(String)
        case placeholder
    }
}
