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
        }
    }
}
