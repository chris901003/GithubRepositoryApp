//
//  RootView.swift
//  GithubRepositoryApp
//
//  Created by 黃弘諺 on 2023/7/4.
//

import SwiftUI

struct RootView: View {
    
    @EnvironmentObject var sharedInfo: SharedInfo
    @State var tabSelect: TabSelection = .all
    
    var body: some View {
        ZStack {
            TabView(selection: $tabSelect) {
                AllRepositoryView(sharedInfo: sharedInfo)
                    .tabItem {
                        Image(SF: .box)
                        Text("倉庫")
                    }
                    .tag(TabSelection.all)
//                FavoriteRepositoryView(sharedInfo: sharedInfo)
//                    .tabItem {
//                        Image(SF: .fillStar)
//                        Text("喜好")
//                    }
//                    .tag(TabSelection.favorite)
            }
            
            VStack {
                if let message = sharedInfo.alertMessage?.rawValue as? String,
                   let type = sharedInfo.alertType {
                    GitRepoAlertView(message: message, type: type)
                        .transition(AnyTransition.move(edge: .trailing))
                }
            }
            .animation(.easeOut(duration: 0.3), value: sharedInfo.alertType)
        }
    }
}

extension RootView {
    enum TabSelection: Int {
        case all, favorite
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
            .environmentObject(SharedInfo.mockDataInit())
    }
}
