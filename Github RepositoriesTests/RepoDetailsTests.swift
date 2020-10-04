//
//  RepoDetailsTests.swift
//  Github RepositoriesTests
//
//  Created by Mohamed Fawzy on 10/3/20.
//  Copyright © 2020 fuzzix. All rights reserved.
//

import XCTest
@testable import Github_Repositories

class RepoDetailsTests: XCTestCase {

    var sut: DetailsViewController!
    var user = User(name: nil, company: nil, location: nil, email: nil, bio: nil, twitterUsername: nil, followers: nil, following: nil)

    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Details", bundle: nil)
        sut = storyboard.instantiateViewController(identifier: "DetailsViewController") as? DetailsViewController
        sut.loadViewIfNeeded()
    }

    override func tearDown() {
        self.sut = nil
        super.tearDown()
    }
    
    func test_userName_match_name_in_view() {
        // given
        let name = "Test name"
        self.user.name = name
        // where
        let viewModel = DetailsViewModel(user: self.user, delegate: sut)
        sut.viewModel = viewModel
        sut.didUpdateData()
        // then
        XCTAssertEqual(sut.userNameLabel.text, name)
    }
    
    func test_userName_match_name_in_view_where_no_name() {
        // given
        self.user.name = nil
        // where
        let viewModel = DetailsViewModel(user: user, delegate: sut)
        sut.viewModel = viewModel
        sut.didUpdateData()
        // then
        XCTAssertNil(sut.userNameLabel.text)
    }
    
    func test_company_match_company_in_view_() {
        // given
        let company = "text company"
        self.user.company = company
        // where
        let viewModel = DetailsViewModel(user: user, delegate: sut)
        sut.viewModel = viewModel
        sut.didUpdateData()
        // then
        XCTAssertEqual(sut.companyLabel.text, "@\(company)")
    }
    
    func test_location_match_location_in_view() {
        // given
        let location = "test location"
        self.user.location = location
        // where
        let viewModel = DetailsViewModel(user: user, delegate: sut)
        sut.viewModel = viewModel
        sut.didUpdateData()
        // then
        XCTAssertEqual(sut.locationLabel.text, location)
    }
    
    func test_bio_match_bio_in_view() {
        // given
        let bio = "test bio"
        self.user.bio = bio
        // where
        let viewModel = DetailsViewModel(user: user, delegate: sut)
        sut.viewModel = viewModel
        sut.didUpdateData()
        // then
        XCTAssertEqual(sut.bioLabel.text, bio)
    }
    
    func test_bio_is_nil_bio_text_is_nil() {
        self.user.bio = nil
        // where
        let viewModel = DetailsViewModel(user: user, delegate: sut)
        sut.viewModel = viewModel
        sut.didUpdateData()
        // then
        XCTAssertNil(sut.bioLabel.text)
    }
    
    func test_twitterUsername_match_twitterUsername_in_view() {
        // given
        let twitterUsername = "test twitter User namme"
        self.user.twitterUsername = twitterUsername
        // where
        let viewModel = DetailsViewModel(user: user, delegate: sut)
        sut.viewModel = viewModel
        sut.didUpdateData()
        // then
        XCTAssertEqual(sut.twitterLabel.text, twitterUsername)
    }
    
    func test_twitterUsername_is_nil_twitter_view_is_hidden() {
        self.user.twitterUsername = nil
        // where
        let viewModel = DetailsViewModel(user: user, delegate: sut)
        sut.viewModel = viewModel
        sut.didUpdateData()
        // then
        XCTAssertTrue(sut.twitterView.isHidden)
    }
    
    func test_followers_count_match_followers_count_in_view() {
        // given
        let followersCount = 2
        self.user.followers = followersCount
        // where
        let viewModel = DetailsViewModel(user: user, delegate: sut)
        sut.viewModel = viewModel
        sut.didUpdateData()
        // then
        XCTAssertEqual(sut.followersCountLabel.text, String(followersCount))
    }
    
    func test_if_followers_is_nil_followers_count_in_view_equals_zero() {
        // given
        self.user.followers = nil
        // where
        let viewModel = DetailsViewModel(user: user, delegate: sut)
        sut.viewModel = viewModel
        sut.didUpdateData()
        // then
        XCTAssertEqual(sut.followersCountLabel.text, "0")
    }
    
    func test_followingCount_match_following_count_in_view() {
        // given
        let followingCount = 1
        self.user.following = followingCount
        // where
        let viewModel = DetailsViewModel(user: user, delegate: sut)
        sut.viewModel = viewModel
        sut.didUpdateData()
        // then
        XCTAssertEqual(sut.followingCountLabel.text, String(followingCount))
    }
    
    func test_if_following_is_nil_following_count_in_view_equals_zero() {
        // given
        self.user.following = nil
        // where
        let viewModel = DetailsViewModel(user: user, delegate: sut)
        sut.viewModel = viewModel
        sut.didUpdateData()
        // then
        XCTAssertEqual(sut.followersCountLabel.text, "0")
    }

}
