//
//  SingleUserPlaceholderSnapshotView.swift
//  GithubRepositoryApp
//
//  Created by 黃弘諺 on 2023/7/14.
//

import SwiftUI

struct SingleUserPlaceholderSnapshotView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(Color(hex: "#78C1F3").gradient)
            
            VStack {
                HStack {
                    titleIcon(imageName: "github")
                    Image(SF: .xmark)
                        .resizeFitColor(color: .pink)
                        .frame(width: 15, height: 15)
                    titleIcon(imageName: "widget")
                }
                Text("Github x Widget")
                    .fontColorBold(.title3, .white)
                    .padding(.bottom, 8)
                Text("長按來指定要追蹤的使用者")
                    .fontColorBold(.caption2, .white.opacity(0.8))
                Text("若需要添加新的選項請到APP當中添加")
                    .fontColorBold(.caption2, .white.opacity(0.8))
            }
        }
    }
}

extension SingleUserPlaceholderSnapshotView {
    func titleIcon(imageName: String) -> some View {
        Image(imageName)
            .renderingMode(.template)
            .resizable()
            .scaledToFit()
            .foregroundStyle(.linearGradient(colors: [Color(hex: "#D61355"), Color(hex: "#F94A29")], startPoint: .topLeading, endPoint: .bottomTrailing))
            .frame(width: 30, height: 30)
    }
}
