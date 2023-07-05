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
    @MainActor
    func addNewRepo(_ newRepoName: String) async {
        if newRepoName.isEmpty {
            // 倉庫名稱為空
            sharedInfo.alertMessage = ModifyRepoError.emptyRepoName
            sharedInfo.alertType = .error
        } else if sharedInfo.allRepo.contains(newRepoName) {
            // 已經存在
            sharedInfo.alertMessage = ModifyRepoError.duplicateRepo
            sharedInfo.alertType = .error
        } else {
            // 添加新倉庫
            sharedInfo.alertMessage = ModifyRepoError.addSuccess
            sharedInfo.alertType = .success
            sharedInfo.allRepo.append(newRepoName)
        }
    }
}

extension AllRepositoryViewModel {
    enum ModifyRepoError: String, LocalizedError {
        case emptyRepoName = "名稱不可為空"
        case duplicateRepo = "已存在"
        case addSuccess = "成功添加"
    }
}
