//
//  Image+.swift
//  GithubRepositoryApp
//
//  Created by 黃弘諺 on 2023/7/4.
//

import SwiftUI

// MARK: Init
extension Image {
    init(SF SFName: SFSymbols) {
        self.init(systemName: SFName.rawValue)
    }
}

// MARK: Modifier
extension Image {
    func resizeFitColor(color: Color = .black) -> some View {
        resizable()
            .scaledToFit()
            .foregroundColor(color)
    }
}
