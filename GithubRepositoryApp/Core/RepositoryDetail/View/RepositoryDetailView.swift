//
//  RepositoryDetailView.swift
//  GithubRepositoryApp
//
//  Created by 黃弘諺 on 2023/7/6.
//

import SwiftUI

struct RepositoryDetailView: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var sheetViewSize: CGFloat = SheetSizePreference.defaultValue
    let repoDetailInfo: RepositoryDetailModel
    
    init(repoDetailInfo: RepositoryDetailModel) {
        self.repoDetailInfo = repoDetailInfo
    }
    
    var body: some View {
        VStack {
            hintBarView
            closeButton
            
            VStack(spacing: 32) {
                titleView
                repoInfoView
                repoLanguageView
                repoOwnerView
            }
        }
        .overlay {
            GeometryReader { proxy in
                Color.clear
                    .preference(key: SheetSizePreference.self, value: proxy.size.height)
            }
        }
        .onPreferenceChange(SheetSizePreference.self) {
            sheetViewSize = $0
        }
        .presentationDetents([.height(sheetViewSize)])
    }
}

extension RepositoryDetailView {
    struct SheetSizePreference: PreferenceKey {
        static var defaultValue: CGFloat = 300
        
        static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
            value = nextValue()
        }
    }
}

private extension RepositoryDetailView {
    var titleView: some View {
        HStack {
            Image(SF: .box)
                .resizeFitColor()
                .frame(width: 25, height: 25)
            Link(destination: repoDetailInfo.repoLink) {
                Text(repoDetailInfo.repoName)
                    .fontSizeWithBold(.title3)
                    .foregroundColor(Color.black)
            }
        }
        .padding(.bottom)
    }
    
    var repoInfoView: some View {
        HStack {
            Text("\(repoDetailInfo.lastUpdatePassTime)")
                .font(.system(size: 75))
                .frame(minWidth: 40)
                .overlay(
                    GeometryReader { proxy in
                        Text("days")
                            .font(.headline)
                            .offset(x: proxy.size.width + 5, y: proxy.size.height - 30)
                    }
                )
                .padding(.trailing, 55)
            Grid(verticalSpacing: 4) {
                someInfoView(image: .fillStar, title: "Stars", repoDetailInfo.stars)
                someInfoView(image: .fork, title: "Forks", repoDetailInfo.forks)
                someInfoView(image: .exclamationmark, title: "Issues", repoDetailInfo.issues)
            }
            .foregroundColor(Color.secondary)
        }
        .foregroundColor(repoDetailInfo.updatePassTimeColor)
    }
    
    var repoLanguageView: some View {
        VStack {
            HStack {
                Image("coding")
                    .resizeFitColor()
                    .frame(width: 30, height: 30)
                Text("Coding Language")
                    .fontSizeWithBold(.title3)
            }
            Grid {
                ForEach(repoDetailInfo.languagesUse, id: \.name) { languageInfo in
                    GridRow {
                        Text("\(languageInfo.name): ").gridColumnAlignment(.leading)
                        Text("\(languageInfo.lines)").gridColumnAlignment(.trailing)
                    }
                    .font(.headline)
                    .padding(.bottom, 4)
                }
            }
        }
    }
    
    var repoOwnerView: some View {
        HStack {
            CacheAsyncImageView(url: repoDetailInfo.owner.photoLink)
                .frame(width: 60, height: 60)
                .clipShape(Circle())
                .padding(.trailing, 8)
            VStack(alignment: .leading, spacing: 4) {
                Text(repoDetailInfo.owner.name)
                    .fontSizeWithBold(.title3)
                HStack {
                    Image("github-logo")
                        .resizeFitColor()
                        .frame(width: 20, height: 20)
                    Link("Github", destination: repoDetailInfo.owner.githubLink)
                }
            }
        }
    }
}

private extension RepositoryDetailView {
    func someInfoView(image imageName: SFSymbols, title: String, _ message: Int) -> some View {
        GridRow {
            Image(SF: imageName)
                .resizeFitColor(color: .secondary)
                .frame(width: 15, height: 15)
            Text(title).gridColumnAlignment(.leading)
            Text("\(message)").gridColumnAlignment(.trailing)
        }
    }
}

private extension RepositoryDetailView {
    var hintBarView: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: 40, height: 5)
            .foregroundColor(Color.secondary)
            .padding(.top, 8)
    }
    
    var closeButton: some View {
        HStack {
            Spacer()
            Button{
              dismiss()
            } label: {
                Image(SF: .xmark)
                    .resizeFitColor()
                    .bold()
                    .frame(width: 15, height: 15)
            }
        }
        .padding(.trailing)
    }
}
