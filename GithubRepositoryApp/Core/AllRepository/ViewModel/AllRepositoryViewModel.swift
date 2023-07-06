//
//  AllRepositoryViewModel.swift
//  GithubRepositoryApp
//
//  Created by 黃弘諺 on 2023/7/4.
//

import Foundation

final class AllRepositoryViewModel {
    
    // Private Variable
    private let sharedInfo: SharedInfo
    
    // Init Function
    init(sharedInfo: SharedInfo) {
        self.sharedInfo = sharedInfo
    }
}

extension AllRepositoryViewModel {
    
    /// 添加新的倉庫連結
    @MainActor
    func addNewRepo(_ newRepoLink: String) async {
        if newRepoLink.isEmpty {
            // 倉庫名稱為空
            sharedInfo.alertMessage = ModifyRepoError.emptyRepoName
            sharedInfo.alertType = .error
        } else if sharedInfo.allRepo.contains(where: \.repoLink == newRepoLink) {
            // 已經存在
            sharedInfo.alertMessage = ModifyRepoError.duplicateRepo
            sharedInfo.alertType = .error
        } else if !checkRepoLinkValid(repoLink: newRepoLink) {
            // 添加倉庫名稱不合法
            sharedInfo.alertMessage = ModifyRepoError.inValidRepoLink
            sharedInfo.alertType = .error
        } else {
            // 添加新倉庫
            sharedInfo.alertMessage = ModifyRepoError.addSuccess
            sharedInfo.alertType = .success
            sharedInfo.allRepo.append(.init(repoLink: newRepoLink))
        }
    }
    
    /// 由小到大排序
    @MainActor
    func sortAllRepo() async {
        sharedInfo.allRepo = sharedInfo.allRepo.sorted(\.repoLink)
    }
    
    /// 刪除選中的倉庫
    @MainActor
    func removeSelectedRepo(selection: Set<String>) async {
        sharedInfo.allRepo.removeAll { selection.contains($0.repoLink) }
    }
    
    @MainActor
    func changeFavoriateState(repoInfo: RepositoryModel) async {
        let idx = sharedInfo.allRepo.targetIdx(\.repoLink, target: repoInfo.repoLink)
        guard let idx = idx else { return }
        sharedInfo.allRepo[idx].isFavoriate.toggle()
    }
}

private extension AllRepositoryViewModel {
    // 檢查倉庫連結是否正確
    func checkRepoLinkValid(repoLink: String) -> Bool {
        let seperateResult = repoLink.components(separatedBy: "/")
        guard seperateResult.count == 2 else { return false }
        return true
    }
}

extension AllRepositoryViewModel {
    enum ModifyRepoError: String, LocalizedError {
        case emptyRepoName = "名稱不可為空"
        case duplicateRepo = "已存在"
        case addSuccess = "成功添加"
        case inValidRepoLink = "倉庫名稱不合法"
    }
}
