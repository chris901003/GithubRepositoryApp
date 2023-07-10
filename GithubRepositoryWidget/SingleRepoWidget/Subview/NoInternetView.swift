//
//  NoInternetView.swift
//  GithubRepositoryWidgetExtension
//
//  Created by 黃弘諺 on 2023/7/10.
//

import SwiftUI

struct NoInternet: View {
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(Color(hex: "#fd4f44").gradient)
            VStack {
                Image("no-internet")
                    .resizeFitColor()
                    .frame(width: 50, height: 50)
                HStack(spacing: 0) {
                    Text("Ooops")
                        .fontColorBold(.headline, .white.opacity(0.9))
                    Image("exclamation")
                        .renderingMode(.template)
                        .resizeFitColor(color: .white.opacity(0.9))
                        .frame(width: 20, height: 20)
                }
                .padding(.bottom, 8)
                Text("網路連線失敗")
                    .fontColorBold(.caption2, .white.opacity(0.9))
                Text("點擊進入APP重新嘗試")
                    .fontColorBold(.caption2, .white.opacity(0.9))
            }
        }
    }
}
