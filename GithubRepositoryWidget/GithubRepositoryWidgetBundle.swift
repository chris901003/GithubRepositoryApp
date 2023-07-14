//
//  GithubRepositoryWidgetBundle.swift
//  GithubRepositoryWidget
//
//  Created by 黃弘諺 on 2023/7/10.
//

import WidgetKit
import SwiftUI

@main
struct GithubRepositoryWidgetBundle: WidgetBundle {
    var body: some Widget {
        SingleRepoWidget()
        SingleUserWidget()
    }
}
