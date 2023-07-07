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
    
    init(repoInfo: Binding<RepositoryModel?>) {
        self._repoInfo = .init(projectedValue: repoInfo)
        self._vm = .init(initialValue: .init(repoLink: repoInfo.wrappedValue!.repoLink))
    }
    
    var body: some View {
        VStack {
            hintBarView
            closeButton
            CacheAsyncImageView(url: URL(string: vm.repoInfo.owner.photoLink)!)
            Spacer()
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
