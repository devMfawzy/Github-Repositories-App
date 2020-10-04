//
//  Github_RepositoriesTests.swift
//  Github RepositoriesTests
//
//  Created by Mohamed Fawzy on 10/2/20.
//  Copyright © 2020 fuzzix. All rights reserved.
//

import XCTest
@testable import Github_Repositories

class RepositoriesTests: XCTestCase {
    
    var sut: RepositoriesViewController!
    var repository = Repository(id: 1, name: "", description: nil, owner: nil)
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(identifier: "RepositoriesViewController") as? RepositoriesViewController
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        self.sut = nil
        super.tearDown()
    }
        
    func test_table_view_items_count_match_model() {
        // given
        let repositories = [repository]
        sut.viewModel = RepositoriesViewModel(repositories: repositories, delegate: sut)
        // where
        sut.didUpdateData()
        // then
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), repositories.count)
    }
    
    func test_repoName_match_cell_repo_label() {
        // given
        let name = "test name"
        self.repository = Repository(id: 1, name: name, description: nil, owner: nil)
        let viewModel = RepositoriesViewModel(repositories: [repository], delegate: sut)
        // where
        sut.viewModel = viewModel
        sut.didUpdateData()
        let cell = sut.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! RepoViewCell
        // then
        XCTAssertEqual(cell.repoNameLabel.text, name)
    }
    
    func test_repo_ownerName_match_cell_owner_label() {
        // given
        let login = "test login"
        let owner = Owner(login: login, avatarUrl: nil, url: nil)
        self.repository.owner = owner
        let viewModel = RepositoriesViewModel(repositories: [self.repository], delegate: sut)
        // where
        sut.viewModel = viewModel
        sut.didUpdateData()
        let cell = sut.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! RepoViewCell
        // then
        XCTAssertEqual(cell.ownerNameLabel.text, login)
        XCTAssertTrue(sut.errorPlaceholderView.isHidden)
    }
    
    func test_where_no_repo_error_view_appears() {
        // given
        let viewModel = RepositoriesViewModel(repositories: [], delegate: sut)
        // where
        sut.viewModel = viewModel
        sut.didFindError(description: "any Error")
        // then
        XCTAssertFalse(sut.errorPlaceholderView.isHidden)
    }
    
}
