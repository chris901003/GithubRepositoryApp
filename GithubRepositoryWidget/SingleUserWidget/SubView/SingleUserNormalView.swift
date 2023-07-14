//
//  SingleUserNormalView.swift
//  GithubRepositoryApp
//
//  Created by 黃弘諺 on 2023/7/14.
//

import SwiftUI

struct SingleUserNormalView: View {
    
    let basicInfo: UserFollowModel
    let detailInfo: FollowUserDetailModel
    
    init(detailInfo: FollowUserDetailModel) {
        self.detailInfo = detailInfo
        self.basicInfo = detailInfo.basicInfo
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(Color(hex: "#B8E8FC").gradient)
            VStack {
                HStack {
                    if let imageData = basicInfo.photoData,
                       let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizeFitColor()
                            .frame(width: 35, height: 35)
                            .clipShape(Circle())
                    } else {
                        Image(SF: .person)
                            .resizeFitColor()
                            .frame(width: 35, height: 35)
                    }
                    VStack(alignment: .leading) {
                        Text(basicInfo.name)
                            .fontSizeWithBold(.caption)
                        Text(basicInfo.user)
                            .fontColorBold(.caption2, .black.opacity(0.7))
                    }
                }
                .padding(.bottom, 8)
                HStack {
                    VStack {
                        Grid(verticalSpacing: 4) {
                            userBasicInfo(image: .twoPreson, title: "Followers", message: basicInfo.followers)
                            userBasicInfo(image: .box, title: "Repos", message: basicInfo.publicRepos)
                        }
                    }
                    .padding(.trailing)
                    VStack {
                        HStack {
                            Image(SF: .box)
                                .resizeFitColor()
                                .frame(width: 15, height: 15)
                            Text("Recent Repos")
                                .fontSizeWithBold(.subheadline)
                        }
                        .padding(.bottom, 2)
                        ForEach(detailInfo.repos) { repoInfo in
                            HStack(spacing: 4) {
                                Text(repoInfo.name).fontSizeWithBold(.caption2)
                                Text("\(repoInfo.lastUpdatePassTime)days").fontColorBold(.caption2, repoInfo.updatePassTimeColor)
                            }
                        }
                    }
                }
            }
        }
        .foregroundColor(Color.black)
    }
}

private extension SingleUserNormalView {
    func userBasicInfo(image: SFSymbols, title: String, message: Int) -> some View {
        GridRow {
            Image(SF: image)
                .resizeFitColor()
                .frame(width: 15, height: 15)
            Text(title).fontSizeWithBold(.caption2)
            Text("\(message)")
                .fontSizeWithBold(.caption2)
        }
    }
}
