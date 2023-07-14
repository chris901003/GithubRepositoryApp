//
//  SingleUserWidget.swift
//  GithubRepositoryApp
//
//  Created by 黃弘諺 on 2023/7/14.
//

import SwiftUI
import WidgetKit


struct SingleUserWidgeteEntry: TimelineEntry {
    let date: Date
    let viewInfo: SingleUserWidgetView.SingleUserWidgetViewType
}

struct SingleUserWidget: Widget {
    let kind = "SingleUserWidgtet"
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: SingleUserWidgetProvider()) { entry in
            SingleUserWidgetView(viewInfo: entry.viewInfo)
        }
        .configurationDisplayName("監看指定使用者")
        .description("每小時更新一次資訊")
        .supportedFamilies([.systemMedium])
    }
}
