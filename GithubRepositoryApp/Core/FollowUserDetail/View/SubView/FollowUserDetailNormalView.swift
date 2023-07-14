//
//  NormalView.swift
//  GithubRepositoryApp
//
//  Created by 黃弘諺 on 2023/7/14.
//

import SwiftUI

extension FollowUserDetail {
    struct FollowUserDetailNormalView: View {
        
        @Environment(\.dismiss) var dismiss
        private let basicInfo: UserFollowModel
        private let detailInfo: FollowUserDetailModel
        @State private var repoScrollSize: CGFloat = FollowUserDetail.FollowUserDetailNormalView.RepoDetailScrollPreference.defaultValue
        @State private var sheetSize: CGFloat = FollowUserDetail.FollowUserDetailSheetSizePreference.defaultValue
        
        init(userInfoDetail: FollowUserDetailModel) {
            self.basicInfo = userInfoDetail.basicInfo
            self.detailInfo = userInfoDetail
        }
        
        var body: some View {
            VStack {
                avatarAndNameView
                userImportantInfoView
                Image("dividing-line").resizeFitColor().frame(maxWidth: .infinity)
                repoDetailSeperateLine
                repoDetailView
            }
            .overlay {
                xmarkView
            }
            .padding()
            .sheetAutoHeight(keyType: FollowUserDetail.FollowUserDetailSheetSizePreference.self, sheetHeight: $sheetSize)
        }
    }
}

// MARK: RepoDetailScrollPreference
extension FollowUserDetail.FollowUserDetailNormalView {
    struct RepoDetailScrollPreference: PreferenceKey {
        static var defaultValue: CGFloat = 300
        static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
            value = nextValue()
        }
    }
}

private extension FollowUserDetail.FollowUserDetailNormalView {
    var avatarAndNameView: some View {
        HStack(spacing: 16) {
            CacheAsyncImageView(url: basicInfo.photoLink)
                .frame(width: 70, height: 70)
                .clipShape(Circle())
            VStack(alignment: .leading) {
                Text(basicInfo.name)
                    .fontSizeWithBold(.title3)
                Text(basicInfo.user)
                    .fontColorBold(.headline, .secondary)
            }
        }
        .padding(.bottom, 8)
    }
    
    var userImportantInfoView: some View {
        Grid(horizontalSpacing: 16, verticalSpacing: 4) {
            GridRow {
                iconWithLabel(sfImage: .twoPreson, message: "Followers")
                iconWithLabel(sfImage: .box, message: "Repositories")
                iconWithLabel(imageName: "github-logo", message: "Github Link")
            }
            GridRow {
                Text("\(basicInfo.followers)").fontColorBold(.headline, .secondary)
                Text("\(basicInfo.publicRepos)").fontColorBold(.headline, .secondary)
                Link(destination: basicInfo.githubURL) { Text("Link").font(.headline) }
            }
        }
        .padding(.bottom)
    }
    
    var repoDetailSeperateLine: some View {
        HStack {
            Image(SF: .box)
                .resizeFitColor()
                .frame(width: 25, height: 25)
            Text("Recent Update Repositories")
                .fontSizeWithBold(.title2)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal)
    }
    
    var repoDetailView: some View {
        ScrollView {
            Grid {
                ForEach(detailInfo.repos) { repoInfo in
                    Link(destination: repoInfo.repoURL) {
                        Text(repoInfo.name)
                            .fontColorBold(.title3, .black)
                    }
                    GridRow {
                        iconWithLabel(sfImage: .twoArrow, message: "Update", font: .subheadline)
                        iconWithLabel(imageName: "coding", message: "Language", font: .subheadline)
                    }
                    GridRow {
                        HStack {
                            Text("\(repoInfo.lastUpdatePassTime)").fontColorBold(.subheadline, repoInfo.updatePassTimeColor)
                            Text("days").fontSizeWithBold(.subheadline)
                        }
                        Text(repoInfo.mainLanguage).fontSizeWithBold(.subheadline)
                    }
                    RoundedRectangle(cornerRadius: 5)
                        .frame(maxWidth: .infinity, maxHeight: 1)
                        .foregroundColor(Color.secondary)
                        .padding(.horizontal)
                    .padding(.bottom, 8)
                }
            }
            .overlay {
                GeometryReader { proxy in
                    Color.clear.preference(key: FollowUserDetail.FollowUserDetailNormalView.RepoDetailScrollPreference.self, value: proxy.size.height)
                }
            }
            .onPreferenceChange(FollowUserDetail.FollowUserDetailNormalView.RepoDetailScrollPreference.self) { repoScrollSize = min($0, 300) }
        }
        .frame(maxHeight: repoScrollSize)
    }
    
    var xmarkView: some View {
        VStack {
            Image(SF: .xmark)
                .resizeFitColor(color: .pink)
                .bold()
                .frame(width: 20, height: 20)
                .onTapGesture { dismiss() }
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
}

private extension FollowUserDetail.FollowUserDetailNormalView {
    func iconWithLabel(sfImage: SFSymbols? = nil, imageName: String? = nil, message: String, font: Font = .caption) -> some View {
        HStack {
            if let sfImage {
                Image(SF: sfImage)
                    .resizeFitColor()
                    .frame(width: 20, height: 20)
            } else {
                Image(imageName!)
                    .resizeFitColor()
                    .frame(width: 20, height: 20)
            }
            Text(message)
                .fontSizeWithBold(font)
        }
    }
}
