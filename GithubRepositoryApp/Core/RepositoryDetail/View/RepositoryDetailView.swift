//
//  RepositoryDetailView.swift
//  GithubRepositoryApp
//
//  Created by 黃弘諺 on 2023/7/6.
//

import SwiftUI

struct RepositoryDetailView: View {
    
    @Binding var repoInfo: RepositoryModel?
    @ObservedObject var vm: RepositoryDetailViewModel
    
    init(sharedInfo: SharedInfo, repoInfo: Binding<RepositoryModel?>) {
        self._repoInfo = .init(projectedValue: repoInfo)
        self._vm = .init(initialValue: .init(sharedInfo: sharedInfo, repoName: repoInfo.wrappedValue!.repoLink))
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
                    .preference(key: AllRepositoryView.SheetSizePreference.self, value: proxy.size.height)
            }
        }
    }
}

private extension RepositoryDetailView {
    var titleView: some View {
        HStack {
            Image(SF: .box)
                .resizeFitColor()
                .frame(width: 25, height: 25)
            Text(vm.repoInfo.repoName)
                .fontSizeWithBold(.title3)
        }
        .padding(.bottom)
    }
    
    var repoInfoView: some View {
        HStack {
            Text("\(vm.repoInfo.lastUpdatePassTime)")
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
                someInfoView(image: .fillStar, title: "Stars", vm.repoInfo.stars)
                someInfoView(image: .fork, title: "Forks", vm.repoInfo.forks)
                someInfoView(image: .exclamationmark, title: "Issues", vm.repoInfo.issues)
            }
            .foregroundColor(Color.secondary)
        }
        .foregroundColor(vm.repoInfo.updatePassTimeColor)
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
                ForEach(vm.repoInfo.languagesUse, id: \.name) { languageInfo in
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
            CacheAsyncImageView(url: vm.repoInfo.owner.photoLink)
                .frame(width: 60, height: 60)
                .clipShape(Circle())
                .padding(.trailing, 8)
            VStack(alignment: .leading, spacing: 4) {
                Text(vm.repoInfo.owner.name)
                    .fontSizeWithBold(.title3)
                HStack {
                    Image("github-logo")
                        .resizeFitColor()
                        .frame(width: 20, height: 20)
                    Link("Github", destination: vm.repoInfo.owner.githubLink)
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
              repoInfo = nil
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
