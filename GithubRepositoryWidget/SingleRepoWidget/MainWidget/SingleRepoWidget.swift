//
//  SingleRepoWidget.swift
//  GithubRepositoryAppTests
//
//  Created by 黃弘諺 on 2023/7/10.
//

import SwiftUI
import WidgetKit

struct SingleRepoWidgetEntry: TimelineEntry {
    let date: Date
    let singleRepoView: SingleRepoWidgetView.SingleRepoView
}

struct SingleRepoWidget: Widget {
    let kind: String = "SingleRepoWidget"
    
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: SingleRepoSelectIntent.self, provider: SingleRepoWidgetProvider()) { entry in
            SingleRepoWidgetView(singleRepoView: entry.singleRepoView)
        }
        .configurationDisplayName("監看指定倉庫")
        .description("每小時更新一次倉庫資訊")
        .supportedFamilies([.systemMedium])
    }
}
