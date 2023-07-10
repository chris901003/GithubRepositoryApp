//
//  SingleRepoWidget.swift
//  GithubRepositoryAppTests
//
//  Created by 黃弘諺 on 2023/7/10.
//

import SwiftUI
import WidgetKit

struct SingleRepoWidgetProvider: TimelineProvider {
    func placeholder(in context: Context) -> SingleRepoWidgetEntry {
        .init(date: .now, singleRepoView: .placeHolder)
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SingleRepoWidgetEntry) -> Void) {
        completion(.init(date: .now, singleRepoView: .snapshot))
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<SingleRepoWidgetEntry>) -> Void) {
        let entry = SingleRepoWidgetEntry(date: .now, singleRepoView: .repoInfo(.mock()))
        let timeline = Timeline(entries: [entry], policy: .never)
        completion(timeline)
    }
}

struct SingleRepoWidgetEntry: TimelineEntry {
    let date: Date
    let singleRepoView: SingleRepoWidgetView.SingleRepoView
}

struct SingleRepoWidgetView: View {
    let singleRepoView: SingleRepoView
    
    var body: some View { singleRepoView }
}

struct SingleRepoWidget: Widget {
    let kind: String = "SingleRepoWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: SingleRepoWidgetProvider()) { entry in
            SingleRepoWidgetView(singleRepoView: entry.singleRepoView)
        }
        .configurationDisplayName("監看指定倉庫")
        .description("每小時更新一次倉庫資訊")
        .supportedFamilies([.systemMedium])
    }
}

// MARK: Real View Creater
extension SingleRepoWidgetView {
    enum SingleRepoView: View {
        case placeHolder
        case snapshot
        case noInternet
        case repoInfo(RepositoryDetailModel)
        
        var body: some View {
            switch self {
                case .placeHolder, .snapshot:
                    PlaceholderSnapshotView()
                case .noInternet:
                    NoInternet()
                case .repoInfo(let repoInfo):
                    RepoInfoView(repoInfo: repoInfo)
            }
        }
    }
}
