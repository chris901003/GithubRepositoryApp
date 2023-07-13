//
//  View+.swift
//  GithubRepositoryApp
//
//  Created by 黃弘諺 on 2023/7/4.
//

import SwiftUI

extension View {
    func roundRectangleBackground(cornerRadius: CGFloat, color: Color = .black, linewidth: CGFloat) -> some View {
        background(
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(color, lineWidth: linewidth)
        )
    }
    
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
    
    /// 兩個方向的Padding，只能剛好兩個
    func twoWayPadding(types: [Edge.Set], sizes: [CGFloat]) -> some View {
        padding(types[0], sizes[0] == 0 ? 16 : sizes[0])
            .padding(types[1], sizes[1] == 0 ? 16 : sizes[1])
    }
    
    func tapDismissView(isShow: Binding<Bool>) -> some View {
        onTapGesture {
            withAnimation {
                isShow.wrappedValue = false
            }
        }
    }
}
