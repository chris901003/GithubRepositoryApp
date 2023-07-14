//
//  SingleUserWidgetView.swift
//  GithubRepositoryApp
//
//  Created by 黃弘諺 on 2023/7/14.
//

import SwiftUI

struct SingleUserWidgetView: View {
    
    let viewInfo: SingleUserWidgetView.SingleUserWidgetViewType
    
    var body: some View {
        viewInfo
    }
}

extension SingleUserWidgetView {
    enum SingleUserWidgetViewType: View {
        case placeholder
        case snapshot
        case noInternet
        case normal(FollowUserDetailModel)
        
        var body: some View {
            switch self {
                case .placeholder, .snapshot:
                    SingleUserPlaceholderSnapshotView()
                case .noInternet:
                    SingleUserNoInternetView()
                case .normal(let detailInfo):
                    SingleUserNormalView(detailInfo: detailInfo)
            }
        }
    }
}
