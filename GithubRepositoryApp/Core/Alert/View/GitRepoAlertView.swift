//
//  GitRepoAlertView.swift
//  GithubRepositoryApp
//
//  Created by 黃弘諺 on 2023/7/4.
//

import SwiftUI

struct GitRepoAlertView: View {
    
    @EnvironmentObject var sharedInfo: SharedInfo
    @State var bottomBarXOffset: CGFloat = -75
    
    let message: String
    let type: AlterType
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                VStack(spacing: 4) {
                    HStack {
                        Image(SF: .exclamationmark)
                            .resizeFitColor(color: .pink)
                            .frame(width: 50, height: 50)
                        VStack(alignment: .leading) {
                            Text("錯誤")
                                .fontSizeWithBold(.title3)
                                .foregroundColor(Color.pink)
                            Text(message)
                                .font(.headline)
                                .foregroundStyle(Color.pink.gradient)
                        }
                    }
                    RoundedRectangle(cornerRadius: 5)
                        .frame(width: 100, height: 3)
                        .foregroundStyle(Color.pink)
                        .offset(x: bottomBarXOffset)
                }
                .clipped()
                .padding(.vertical, 8)
                .padding(.horizontal)
                .background(Color.pink.opacity(0.1))
                .cornerRadius(10)
                .onAppear {
                    withAnimation(.linear(duration: 0.7).repeatForever(autoreverses: true)) {
                        bottomBarXOffset = 75
                    }
                }
            }
            Spacer()
        }
        .transition(AnyTransition.move(edge: .trailing))
    }
}

extension GitRepoAlertView {
    enum AlterType: String {
        case success = "成功"
        case error = "失敗"
    }
}

struct GitRepoAlertView_Previews: PreviewProvider {
    static var previews: some View {
        GitRepoAlertView(message: "名稱不可為空", type: .error)
            .environmentObject(SharedInfo())
    }
}
