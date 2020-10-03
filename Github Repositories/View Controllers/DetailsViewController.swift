//
//  DetailsViewController.swift
//  Github Repositories
//
//  Created by Mohamed Fawzy on 10/2/20.
//  Copyright © 2020 fuzzix. All rights reserved.
//

import UIKit
import SDWebImage
import ABLoaderView
import Toast_Swift

class DetailsViewController: UIViewController {

    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var loginNameLabel: UILabel!
    @IBOutlet private weak var bioLabel: UILabel!
    @IBOutlet private weak var companyLabel: UILabel!
    @IBOutlet private weak var locationLabel: UILabel!
    @IBOutlet private weak var followersCountLabel: UILabel!
    @IBOutlet private weak var followingCountLabel: UILabel!
    @IBOutlet private weak var twitterLabel: UILabel!
    @IBOutlet private weak var twitterView: UIView!
    @IBOutlet private weak var companyView: UIView!
    @IBOutlet private weak var locatiomView: UIView!
        
    private var viewModel: DetailsViewModel?
    
    weak var dataSource: DetailsViewDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        fetchUserData()
    }
    
    private func setupView() {
        self.title = dataSource?.repoName()
        if let avatarUrl = dataSource?.avatarUrl() {
            avatarImageView?.sd_setImage(with: URL(string: avatarUrl), placeholderImage: #imageLiteral(resourceName: "placeholder"))
        }
        self.loginNameLabel.text = dataSource?.loginName()
    }
    
    private func fetchUserData() {
        guard let userUrl = dataSource?.userUrl() else {
            return
        }
        let userService = GithubRepoService(baseURL: userUrl)
        self.viewModel = DetailsViewModel(userInfoService: userService, delegate: self)
        self.viewModel?.loadData()
    }
    
    func loadData() {
        userNameLabel.text = viewModel?.userName
        bioLabel.text = viewModel?.bio
        if let company = viewModel?.company {
            companyLabel.text = company
        } else {
            companyView.isHidden = true
        }
        if let location = viewModel?.location {
            locationLabel.text = location
        } else {
            locatiomView.isHidden = true
        }
        followersCountLabel.text = viewModel?.followersCount
        followingCountLabel.text = viewModel?.followingCount
        if let twitter = viewModel?.twitterUsername {
            twitterLabel.text = twitter
        } else {
            twitterView.isHidden = true
        }
        ABLoader().stopSmartShining(self.view)
    }
    
}

//MARK: - View Model Delegate

extension DetailsViewController: ViewModelDelegate {
    
    func willFetchData() {
        ABLoader().startSmartShining(self.view)
    }
    
    func didUpdateData() {
        loadData()
    }

    func didFindError(description: String) {
        loadData()
        self.view.makeToast(description, point: self.view.center, title: nil, image: #imageLiteral(resourceName: "icon_error_offline")) { [weak self] (done) in
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
}
