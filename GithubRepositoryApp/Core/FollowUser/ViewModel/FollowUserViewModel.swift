//
//  FollowUserViewModel.swift
//  GithubRepositoryApp
//
//  Created by 黃弘諺 on 2023/7/11.
//

import Foundation
import Combine

class FollowUserViewModel {
    
    // Private Variable
    private let sharedInfo: SharedInfo
    private var userFollowCancelable: AnyCancellable? = nil
    
    // Init Function
    init(sharedInfo: SharedInfo) {
        self.sharedInfo = sharedInfo
        Task { await self.subscribeFollowUser() }
    }
}

extension FollowUserViewModel {
    /// 添加新的追蹤使用者
    @MainActor
    func addNewFollowUser(userName: String) async {
        if userName.isEmpty {
            sharedInfo.changeAlertStatus(type: .error, message: AddNewFollowUserError.emptyName)
            return
        } else if sharedInfo.allFollowUser.contains(where: \.user == userName.lowercased()) {
            sharedInfo.changeAlertStatus(type: .error, message: AddNewFollowUserError.userExisted)
            return
        } else {
            sharedInfo.changeAlertStatus(type: .success, message: AddNewFollowUserError.fetching)
        }
        guard let url = "https://api.github.com/users/\(userName)".toURL() else {
            sharedInfo.changeAlertStatus(type: .error, message: AddNewFollowUserError.notFound)
            return
        }
        let urlRequest = URLRequest(url: url)
        do {
            var userInfo = try await HttpRequestManager.shared.fetchData(urlRequest: urlRequest, dataType: UserFollowModel.self, session: .userSession)
            try await userInfo.fetchUserPhotoData()
            sharedInfo.allFollowUser.append(userInfo)
            sharedInfo.changeAlertStatus(type: .success, message: AddNewFollowUserError.success)
        } catch {
            sharedInfo.changeAlertStatus(type: .error, message: AddNewFollowUserError.internet)
        }
    }
    
    /// 移除編輯中選中的使用者
    @MainActor
    func removeSelectedUser(selected: Set<Int>) {
        sharedInfo.allFollowUser.removeAll { selected.contains($0.id) }
    }
    
    /// 獲取指定使用者詳細資料
    func fetchUserInfo(userInfo: UserFollowModel) async throws -> FollowUserDetailModel {
        var followUserDetail: FollowUserDetailModel = .init(basicInfo: userInfo, repos: [])
        try await followUserDetail.fetchRepos()
        return followUserDetail
    }
    
    @MainActor
    func saveFollowUser() {
        do {
            try sharedInfo.saveAllRepo(key: .userList, data: sharedInfo.allFollowUser)
        } catch {
            sharedInfo.alertType = .error
            sharedInfo.alertMessage = SaveDataError.updateAllFollowUserError
        }
    }
}

private extension FollowUserViewModel {
    // 追蹤變更
    @MainActor
    func subscribeFollowUser() {
        userFollowCancelable = sharedInfo.$allFollowUser
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .receive(on: DispatchQueue.main)
            .sink {[weak self] _ in self?.saveFollowUser() }
    }
}

extension FollowUserViewModel {
    enum AddNewFollowUserError: String, LocalizedError {
        case emptyName = "名稱不可為空"
        case userExisted = "該使用者已存在"
        case notFound = "Github中查無此人"
        case internet = "網路連線失敗，或是查無此人"
        case fetching = "獲取資料中"
        case success = "成功添加"
    }
    
    enum SaveDataError: String, LocalizedError {
        case updateAllFollowUserError = "無法保存資料"
    }
}
