//
//  AllRepositoryView.swift
//  GithubRepositoryApp
//
//  Created by 黃弘諺 on 2023/7/4.
//

import SwiftUI

struct AllRepositoryView: View {
    
    @ObservedObject private var sharedInfo: SharedInfo
    @State private var newRepoName: String = ""
    @State private var isAdding: Bool = false
    
    // Private Variable
    private var vm: AllRepositoryViewModel
    
    init(sharedInfo: SharedInfo) {
        self._sharedInfo = .init(wrappedValue: sharedInfo)
        self.vm = .init(sharedInfo: sharedInfo)
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                addNewRepoView
            }
            .padding(.horizontal)
            .navigationTitle("所有倉庫")
        }
    }
}

private extension AllRepositoryView {
    var addNewRepoView: some View {
        HStack {
            TextField("Ex: chris901003/SwiftLearning", text: $newRepoName)
                .font(.headline)
                .padding(8)
                .roundRectangleBackground(cornerRadius: 5, color: .secondary, linewidth: 2)
                .padding(.horizontal)
            if isAdding {
                ProgressView()
                    .frame(width: 25, height: 25)
            } else {
                Button {
                    Task {
                        isAdding = true
                        await vm.addNewRepo(newRepoName)
                        newRepoName = ""
                        isAdding = false
                    }
                } label: {
                    Image(SF: .plus)
                        .resizeFitColor(color: .green)
                        .frame(width: 25, height: 25)
                }
            }
        }
        .padding(.top)
    }
}

struct AllRepositoryView_Previews: PreviewProvider {
    static var previews: some View {
        AllRepositoryView(sharedInfo: SharedInfo())
    }
}
