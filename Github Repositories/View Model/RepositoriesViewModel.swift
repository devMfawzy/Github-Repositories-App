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
    private(set) var repoService: RepoServiceProtocol?
    private(set) var repositories = [Repository]()
    private var isFetchingData = false
    
    init(repoService: RepoServiceProtocol, delegate: ViewModelDelegate) {
        self.repoService = repoService
        self.delegate = delegate
    }
    
    init(repositories: [Repository], delegate: ViewModelDelegate) {
          self.repositories = repositories
          self.delegate = delegate
    }
    
    func loadData(fetchingMode: FetchingMode = .replace) {
        guard !isFetchingData else { return }
        self.delegate?.willFetchData()
        isFetchingData = true
        repoService?.getRepositories(currentPage, limit: limit) { [weak self] (data, error) in
            if let data = data {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                guard let repositories = try? decoder.decode([Repository].self, from: data) else {
                    self?.isFetchingData = false
                    self?.reportError("Serialization error")
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
                if self?.repositories.isEmpty ?? true {
                    self?.reportError("No Results Yet")
                } else {
                    self?.delegate?.didUpdateData()
                }
            } else if let error = error {
                self?.reportError(error.localizedDescription)
            } else {
                self?.reportError("Unexpected Error")
            }
            self?.isFetchingData = false
        }
    }
    
    private func reportError(_ description: String) {
        self.delegate?.didFindError(description: description)
    }
    
    var itemsCount: Int {
        return repositories.count
    }
    
    func RepositoryAt(index: Int) -> Repository {
        return repositories[index]
    }
    
}
