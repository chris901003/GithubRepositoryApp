//
//  RepoInfoView.swift
//  GithubRepositoryWidgetExtension
//
//  Created by 黃弘諺 on 2023/7/10.
//

import SwiftUI

struct RepoInfoView: View {
    
    let repoInfo: RepositoryDetailModel
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(Color(hex: "#69c0f7").gradient)
            
            VStack(spacing: 4) {
                repoTitleView
                HStack {
                    lastUpdateTime
                    repoImportantInfo
                    mainLanguageView
                }
                .padding(.bottom, 8)
                authorView
            }
        }
    }
}

private extension RepoInfoView {
    var repoTitleView: some View {
        HStack {
            Image(SF: .box)
                .resizeFitColor()
                .frame(width: 20, height: 20)
            Text(repoInfo.repoName)
                .font(.headline)
        }
    }
    
    var lastUpdateTime: some View {
        VStack(spacing: 0) {
            Text("\(repoInfo.lastUpdatePassTime)")
                .font(.system(size: 50))
                .bold()
                .padding(.bottom, -8)
            Text("days")
                .fontColorBold(.caption2, .white.opacity(0.8))
        }
    }
    
    var repoImportantInfo: some View {
        Grid(verticalSpacing: 2) {
            gridItem(image: .fillStar, info: repoInfo.stars)
            gridItem(image: .fork, info: repoInfo.forks)
            gridItem(image: .exclamationmark, info: repoInfo.issues)
        }
        .padding(.trailing)
    }
    
    var mainLanguageView: some View {
        VStack {
            HStack {
                Image("coding")
                    .resizeFitColor()
                    .frame(width: 15, height: 15)
                Text("Main Language")
                    .fontColorBold(.caption, .white)
            }
            ForEach(repoInfo.languagesUse.prefix(2), id: \.name) { languageInfo in
                Text(languageInfo.name)
                    .fontColorBold(.caption2, .white.opacity(0.8))
            }
        }
    }
    
    var authorView: some View {
        HStack {
            Image("github")
                .resizeFitColor()
                .frame(width: 15, height: 15)
            Text(repoInfo.owner.name)
                .fontColorBold(.caption, .white)
        }
    }
}

private extension RepoInfoView {
    func gridItem(image: SFSymbols, info: Int) -> some View {
        GridRow {
            Image(SF: image)
                .resizeFitColor(color: .white.opacity(0.8))
                .frame(width: 10, height: 10)
            Text("\(info)")
                .fontColorBold(.caption2, .white.opacity(0.8))
        }
    }
}
