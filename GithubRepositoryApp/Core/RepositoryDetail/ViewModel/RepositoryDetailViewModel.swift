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
    private let sharedInfo: SharedInfo
    private let repoName: String
    private var repoLink: String { "https://api.github.com/repos/\(repoName)" }
    
    // Init Function
    init(sharedInfo: SharedInfo, repoName: String) {
        self.sharedInfo = sharedInfo
        self.repoName = repoName
        Task {
            await fetchRepoInfo()
        }
    }
}

private extension RepositoryDetailViewModel {
    @MainActor
    func fetchRepoInfo() async {
        // Note: 在此中的Thread皆為Main thread在Manager中的皆不是Main thread
        // 這部分還有大量問題，看一下要不要變成按下指定Repo後才獲取資料，不然現在疑似會瘋狂跑這裡，不知道是誰在呼叫
//        let url = URL(string: repoLink)!
//        let urlRequest = URLRequest(url: url)
//        do {
//            let info = try await HttpRequestManager.shared.fetchData(urlRequest: urlRequest, dataType: RepositoryDetailModel.self)
//            repoInfo = info
//        } catch {
//            Task { @MainActor in
//                let errorTransfer = error as? HttpRequestManager.FetchDataError
//                sharedInfo.alertType = .error
//                sharedInfo.alertMessage = errorTransfer
//            }
//        }
    }
    
    enum FetchSuccess: String, LocalizedError {
        case success = "成功獲取"
    }
}
