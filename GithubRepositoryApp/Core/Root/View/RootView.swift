//
//  RootView.swift
//  GithubRepositoryApp
//
//  Created by 黃弘諺 on 2023/7/4.
//

import SwiftUI

struct RootView: View {
    
    @EnvironmentObject var sharedInfo: SharedInfo
    
    var body: some View {
        ZStack {
            TabView {
                AllRepositoryView(sharedInfo: sharedInfo)
                    .tabItem {
                        Image(SF: .box)
                        Text("倉庫")
                    }
                Text("Favorite")
                    .tabItem {
                        Image(SF: .favorite)
                        Text("喜好")
                    }
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

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
            .environmentObject(SharedInfo.mockDataInit())
    }
}
