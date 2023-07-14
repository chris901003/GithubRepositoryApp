//
//  FollowUserDetailView.swift
//  GithubRepositoryApp
//
//  Created by 黃弘諺 on 2023/7/14.
//

import SwiftUI

struct FollowUserDetail { }

extension FollowUserDetail {
    enum Sheet: View {
        case noInternet
        case normal(FollowUserDetailModel)
        
        var body: some View {
            switch self {
                case .noInternet:
                    FollowUserDetail.FollowUserDetailNoInternetView()
                case .normal(let detailInfo):
                    FollowUserDetail.FollowUserDetailNormalView(userInfoDetail: detailInfo)
            }
        }
    }
}

// MARK: FollowUserDetail Identifiable
extension FollowUserDetail.Sheet: Identifiable {
    var id: String {
        switch self {
            case .noInternet:
                return UUID().uuidString
            case .normal(let detailInfo):
                return detailInfo.basicInfo.reposURL.description
        }
    }
}

extension FollowUserDetail {
    /// Sheet的動態大小
    struct FollowUserDetailSheetSizePreference: PreferenceKey {
        static var defaultValue: CGFloat = 300
        
        static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
            value = nextValue()
        }
    }
}
