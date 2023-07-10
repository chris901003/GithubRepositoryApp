//
//  Placeholder+SnapshotView.swift
//  GithubRepositoryWidgetExtension
//
//  Created by 黃弘諺 on 2023/7/10.
//

import SwiftUI

extension SingleRepoWidgetView {
    struct PlaceholderSnapshotView: View {
        
        var body: some View {
            ZStack {
                Image("PlaceholderSnapshotBackground")
                    .resizable()
                    .scaledToFill()
                VStack {
                    HStack {
                        iconView(imageName: "github")
                        Text("X")
                            .fontColorBold(.title3, .white)
                        iconView(imageName: "widget")
                    }
                    Text("Github x Widget")
                        .fontColorBold(.title2, .white)
                        .padding(.bottom)
                    Text("Github與小工具的結合")
                    Text("長按小工具指定監看的倉庫")
                }
                .font(.subheadline)
                .bold()
                .foregroundColor(Color.white.opacity(0.8))
            }
        }
    }
}


// MARK: For PlaceholderSnapshotView Subview
private extension SingleRepoWidgetView.PlaceholderSnapshotView {
    func iconView(imageName: String) -> some View {
        Image(imageName)
            .renderingMode(.template)
            .resizeFitColor(color: .white)
            .frame(width: 30, height: 30)
            .padding(2)
            .background(
                Circle()
                    .fill(.linearGradient(colors: [Color(hex: "#0556ac"), Color(hex: "#00cefb")], startPoint: .topLeading, endPoint: .bottomTrailing))
            )
    }
}
