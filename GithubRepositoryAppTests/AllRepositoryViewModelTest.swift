//
//  AllRepositoryViewModelTest.swift
//  GithubRepositoryAppTests
//
//  Created by 黃弘諺 on 2023/7/5.
//

import XCTest

class AllRepositoryViewModelTest: XCTestCase {
    
    func testAddNewRepo() throws {
        Task { @MainActor in
            let sharedInfo: SharedInfo = .init()
            let sut: AllRepositoryViewModel = AllRepositoryViewModel(sharedInfo: sharedInfo)
            let newRepoLink: String = "chris901003/GithubRepositoryApp"
            await sut.addNewRepo(newRepoLink)
            XCTAssertEqual(sharedInfo.allRepo.count, 1)
            XCTAssertEqual(sharedInfo.allRepo.first?.repoLink, newRepoLink)
        }
    }
    
    func testAddInvalidNewRepo() throws {
        Task { @MainActor in
            let sharedInfo: SharedInfo = .init()
            let sut: AllRepositoryViewModel = AllRepositoryViewModel(sharedInfo: sharedInfo)
            
            // 只有給使用者名稱，未提供倉庫具體名稱
            var newRepoLink: String = "chris901003"
            await sut.addNewRepo(newRepoLink)
            await checkIsValidState(sharedInfo, alertType: .error, alertMessage: .inValidRepoLink)
            
            // 給定使用者名稱以及倉庫名稱，但是後面又有多餘資料
            newRepoLink = "chris901003/GithubRepositoryApp/OtherInfo"
            await checkIsValidState(sharedInfo, alertType: .error, alertMessage: .inValidRepoLink)
        }
    }
    
    func testAddDuplicateRepo() throws {
        Task { @MainActor in
            let sharedInfo: SharedInfo = .init()
            let sut: AllRepositoryViewModel = AllRepositoryViewModel(sharedInfo: sharedInfo)
            let newRepoLink: String = "chris901003/GithubRepositoryApp"
            await sut.addNewRepo(newRepoLink)
            // 重複加入相同的Repo
            await sut.addNewRepo(newRepoLink)
            await checkIsValidState(sharedInfo, alertType: .error, alertMessage: .duplicateRepo)
        }
    }
    
    func testAddEmptyRepoLink() throws {
        Task { @MainActor in
            let sharedInfo: SharedInfo = .init()
            let sut: AllRepositoryViewModel = .init(sharedInfo: sharedInfo)
            let newRepoLink: String = ""
            await sut.addNewRepo(newRepoLink)
            await checkIsValidState(sharedInfo, alertType: .error, alertMessage: .emptyRepoName)
        }
    }
    
    func testRemoveRepo() throws {
        Task { @MainActor in
            let sharedInfo: SharedInfo = .init()
            let sut: AllRepositoryViewModel = .init(sharedInfo: sharedInfo)
            for idx in 0..<10 { await sut.addNewRepo("\(idx)/\(idx)") }
            var removeList = Set<String>()
            for idx in 0..<5 { removeList.insert("\(idx)/\(idx)") }
            await sut.removeSelectedRepo(selection: removeList)
            for idx in 5..<10 {
                await sut.addNewRepo("\(idx)/\(idx)")
                await checkIsValidState(sharedInfo, alertType: .error, alertMessage: .duplicateRepo)
            }
        }
    }
    
    func testSortRepo() throws {
        Task { @MainActor in
            let sharedInfo: SharedInfo = .init()
            let sut: AllRepositoryViewModel = .init(sharedInfo: sharedInfo)
            await sut.addNewRepo("2/2")
            await sut.addNewRepo("1/1")
            await sut.sortAllRepo()
            let repo = sharedInfo.allRepo
            XCTAssertEqual(repo[0].repoLink, "1/1")
            XCTAssertEqual(repo[1].repoLink, "2/2")
        }
    }
}

private extension AllRepositoryViewModelTest {
    @MainActor
    @Sendable func checkIsValidState(_ sharedInfo: SharedInfo, alertType: GitRepoAlertView.AlterType, alertMessage: AllRepositoryViewModel.ModifyRepoError) async {
        XCTAssertEqual(sharedInfo.allRepo.count, 0)
        XCTAssertNotNil(sharedInfo.alertType)
        XCTAssertNotNil(sharedInfo.alertMessage)
        XCTAssertEqual(sharedInfo.alertType, alertType)
        XCTAssertEqual(sharedInfo.alertMessage?.rawValue as! String, alertMessage.rawValue)
    }
}
