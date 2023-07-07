//
//  RepositoryDetailViewModel.swift
//  GithubRepositoryApp
//
//  Created by 黃弘諺 on 2023/7/6.
//

import Foundation

final class RepositoryDetailViewModel: ObservableObject {
    
    @Published var repoInfo: RepositoryDetailModel = .mock()
    
    // Private Variable
    private let repoLink: String
    
    // Init Function
    init(repoLink: String) {
        self.repoLink = repoLink
        Task {
            await fetchRepoInfo()
        }
    }
}

private extension RepositoryDetailViewModel {
    func fetchRepoInfo() async {
        
    }
}
