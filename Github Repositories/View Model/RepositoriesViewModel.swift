//
//  RepositoriesViewModel.swift
//  Github Repositories
//
//  Created by Mohamed Fawzy on 10/2/20.
//  Copyright © 2020 fuzzix. All rights reserved.
//

import Foundation

class RepositoriesViewModel {
        
    private let limit: Int32 = 10
    private var currentPage: Int32 = 0
    private weak var delegate: ViewModelDelegate?
    private(set) var repoService: GithubRepoService
    private(set) var repositories = [Repository]()
    private var isFetchingData = false
    
    init(repoService: GithubRepoService, delegate: ViewModelDelegate) {
        self.repoService = repoService
        self.delegate = delegate
    }
    
    func loadData(fetchingMode: FetchingMode = .replace) {
        guard !isFetchingData else { return }
        self.delegate?.willFetchData()
        isFetchingData = true
        repoService.getRepositories(currentPage, limit: limit) { [weak self] (data, error) in
            if let data = data {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                guard let repositories = try? decoder.decode([Repository].self, from: data) else {
                    return
                }
                switch fetchingMode {
                case .replace:
                    self?.repositories = repositories
                default:
                    self?.repositories.append(contentsOf: repositories)
                }
                if let newPage = repositories.last?.id {
                    self?.currentPage = Int32(newPage)
                }
                self?.isFetchingData = false
                self?.delegate?.didUpdateData()
            }
        }
    }
    
    var itemsCount: Int {
        return repositories.count
    }
    
    func RepositoryAt(index: Int) -> Repository {
        return repositories[index]
    }
    
}
