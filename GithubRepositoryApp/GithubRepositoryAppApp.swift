//
//  GithubRepositoryAppApp.swift
//  GithubRepositoryApp
//
//  Created by 黃弘諺 on 2023/7/4.
//

import SwiftUI

@main
struct GithubRepositoryAppApp: App {
    
    init() {
        applyTabBarBackground()
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(SharedInfo())
        }
    }
}

func applyTabBarBackground() {
    let tabBarAppearance = UITabBarAppearance()
    tabBarAppearance.configureWithTransparentBackground()
    tabBarAppearance.backgroundColor = .secondarySystemBackground.withAlphaComponent(0.3)
    tabBarAppearance.backgroundEffect = UIBlurEffect(style: .systemChromeMaterial)
    UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
}
