//
//  ViewController.swift
//  Github Repositories
//
//  Created by Mohamed Fawzy on 10/2/20.
//  Copyright © 2020 fuzzix. All rights reserved.
//

import UIKit
import SDWebImage

class RepositoriesViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    private var loadMoreThreshold = 0.8
    
    private var viewModel: RepositoriesViewModel?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        let githubRepoService = GithubRepoService(baseURL: ENV.baseURL )
        self.viewModel = RepositoriesViewModel(repoService: githubRepoService, delegate: self)
        self.viewModel?.loadData()
    }
    
    private func setupView() {
        self.tableView.tableFooterView = UIView()
        self.tableView.register(UINib(nibName: RepoViewCell.identifier, bundle: nil), forCellReuseIdentifier: RepoViewCell.identifier)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.activityIndicator.center = self.view.center
    }

}

//MARK: - Table View Data Source

extension RepositoriesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.itemsCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RepoViewCell.identifier , for: indexPath)
        if let repo = viewModel?.RepositoryAt(index: indexPath.row), let cell = cell as? RepoViewCell {
            cell.config(repoName: repo.name, ownerName: repo.owner?.login, avatarUrl: repo.owner?.avatarUrl)
        }
        return cell
    }
    
}

//MARKL -

extension RepositoriesViewController: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let totalItemsCount = viewModel?.itemsCount else {
            return
        }
        guard let lastDisplayedRow = self.tableView.indexPathsForVisibleRows?.last?.row  else {
            return
        }
        let displayedItemsCount = lastDisplayedRow + 1
        if Double(displayedItemsCount) / Double(totalItemsCount) >= loadMoreThreshold {
            self.viewModel?.loadData(fetchingMode: .append)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailsViewController = UIStoryboard(name: "Details", bundle: nil).instantiateViewController(identifier: "DetailsViewController") as? DetailsViewController else {
            return
        }
        detailsViewController.dataSource = self
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
    
}

//MARK: - Repo Model Delegate

extension RepositoriesViewController: ViewModelDelegate {
    
    func didUpdateData() {
        self.tableView.reloadData()
        self.activityIndicator.stopAnimating()
    }
    
    func willFetchData() {
        self.activityIndicator.startAnimating()
    }
    
}

//MARK: - Details View Data Source

extension RepositoriesViewController: DetailsViewDataSource {
    
    var indexOfSelectedRow: Int? {
        return tableView.indexPathForSelectedRow?.row
    }
    
    func avatarUrl() -> String? {
        guard let index = indexOfSelectedRow else { return nil }
        return viewModel?.RepositoryAt(index: index).owner?.avatarUrl
    }
    
    func loginName() -> String? {
        guard let index = indexOfSelectedRow else { return nil }
        return viewModel?.RepositoryAt(index: index).owner?.login
    }
    
    func repoName() -> String? {
        guard let index = indexOfSelectedRow else { return nil }
        return viewModel?.RepositoryAt(index: index).name
    }
    
    func userUrl() -> String? {
        guard let index = indexOfSelectedRow else { return nil }
        return viewModel?.RepositoryAt(index: index).owner?.url
    }
    
}