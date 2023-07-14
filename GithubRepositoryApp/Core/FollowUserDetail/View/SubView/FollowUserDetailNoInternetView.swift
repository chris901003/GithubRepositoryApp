//
//  NoInternetView.swift
//  GithubRepositoryApp
//
//  Created by 黃弘諺 on 2023/7/14.
//

import SwiftUI

extension FollowUserDetail {
    struct FollowUserDetailNoInternetView: View {
        
        @Environment(\.dismiss) var dismiss
        
        // Private Variable
        @State private var bottomBarXOffset: CGFloat
        @State private var sheetSize: CGFloat = FollowUserDetail.FollowUserDetailSheetSizePreference.defaultValue
        private let screenWidth: CGFloat = UIScreen.main.bounds.width
        
        init() {
            self._bottomBarXOffset = .init(initialValue: -screenWidth * 0.5)
        }
        
        var body: some View {
            VStack {
                HStack {
                    Image("no-connection")
                        .resizeFitColor()
                        .frame(width: 40, height: 40)
                    Text("網路連線失敗")
                        .fontColorBold(.title2, .pink)
                }
                .padding(.bottom)
                Text("網路似乎發生問題，請確認網路狀態")
                    .fontColorBold(.headline, Color.pink.opacity(0.8))
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: screenWidth * 0.4, height: 3)
                    .foregroundColor(Color.pink)
                    .offset(x: bottomBarXOffset)
            }
            .onAppear {
                withAnimation(.linear(duration: 1.5).repeatForever(autoreverses: true)) {
                    bottomBarXOffset = screenWidth * 0.5
                }
            }
            .overlay {
                VStack {
                    Image(SF: .xmark)
                        .resizeFitColor(color: .pink)
                        .frame(width: 15, height: 15)
                        .onTapGesture { dismiss() }
                    Spacer()
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .clipped()
            .padding()
            .sheetAutoHeight(keyType: FollowUserDetail.FollowUserDetailSheetSizePreference.self, sheetHeight: $sheetSize)
        }
    }
}
