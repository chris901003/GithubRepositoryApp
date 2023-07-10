//
//  SingleRepoWidgetView.swift
//  GithubRepositoryWidgetExtension
//
//  Created by 黃弘諺 on 2023/7/10.
//

import SwiftUI

struct SingleRepoWidgetView: View {
    let singleRepoView: SingleRepoView
    
    var body: some View { singleRepoView }
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
