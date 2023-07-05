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
                        Image(SF: type.icon)
                            .resizeFitColor(color: type.mainColor)
                            .frame(width: 50, height: 50)
                        VStack(alignment: .leading) {
                            Text(type.rawValue)
                                .fontSizeWithBold(.title3)
                                .foregroundColor(type.mainColor)
                            Text(message)
                                .font(.headline)
                                .foregroundStyle(type.secondaryColor)
                        }
                    }
                    RoundedRectangle(cornerRadius: 5)
                        .frame(width: 100, height: 3)
                        .foregroundStyle(type.mainColor)
                        .offset(x: bottomBarXOffset)
                }
                .clipped()
                .twoWayPadding(types: [.vertical, .horizontal], sizes: [8, 0])
                .background(type.backgroundColor)
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
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                sharedInfo.removeAlert()
            }
        }
    }
}

extension GitRepoAlertView {
    enum AlterType: String {
        case success = "成功"
        case error = "錯誤"
        
        var icon: SFSymbols {
            switch self {
                case .success:
                    return .checkmark
                case .error:
                    return .exclamationmark
            }
        }
        
        var mainColor: Color {
            switch self {
                case .success:
                    return .green
                case .error:
                    return .pink
            }
        }
        
        var secondaryColor: AnyGradient {
            switch self {
                case .success:
                    return Color.green.gradient
                case .error:
                    return Color.pink.gradient
            }
        }
        
        var backgroundColor: Color {
            switch self {
                case .success:
                    return Color(hex: "#d6f4de")
                case .error:
                    return Color(hex: "#ffeaee")
            }
        }
    }
}

struct GitRepoAlertView_Previews: PreviewProvider {
    static var previews: some View {
        GitRepoAlertView(message: "名稱不可為空", type: .error)
            .environmentObject(SharedInfo())
    }
}
