//
//  SingleUserNoInternetView.swift
//  GithubRepositoryApp
//
//  Created by 黃弘諺 on 2023/7/14.
//

import SwiftUI

struct SingleUserNoInternetView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(Color(hex: "#6ECCAF").gradient)
            
            VStack {
                Image("no-internet")
                    .resizeFitColor()
                    .frame(width: 40, height: 40)
                Text("網路連線錯誤")
                    .fontColorBold(.headline, .pink)
                    .padding(.bottom, 8)
                Text("請確認網路狀態後再試")
                    .fontColorBold(.caption2, .pink)
            }
        }
    }
}
