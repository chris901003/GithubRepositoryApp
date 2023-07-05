//
//  Text+.swift
//  GithubRepositoryApp
//
//  Created by 黃弘諺 on 2023/7/4.
//

import SwiftUI

extension Text {
    func fontSizeWithBold(_ fontSize: Font) -> Text {
        font(fontSize)
            .bold()
    }
    
    func fontColor(_ fontSize: Font, _ color: Color) -> Text {
        font(fontSize)
            .foregroundColor(color)
    }
    
    func fontColorBold(_ fontSize: Font, _ color: Color) -> Text {
        fontSizeWithBold(fontSize)
            .foregroundColor(color)
    }
}
