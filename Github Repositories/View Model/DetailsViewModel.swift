//
//  DetailsViewModel.swift
//  Github Repositories
//
//  Created by Mohamed Fawzy on 10/2/20.
//  Copyright © 2020 fuzzix. All rights reserved.
//

import Foundation

class DetailsViewModel {
    
    private weak var delegate: ViewModelDelegate?
    private var userInfoService: GithubRepoService
    private var user: User?
    
    init(userInfoService: GithubRepoService, delegate: ViewModelDelegate) {
        self.userInfoService = userInfoService
        self.delegate = delegate
    }
    
    func loadData() {
        self.delegate?.willFetchData()
        userInfoService.getInfo() { [weak self] (data, error) in
            if let data = data {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                guard let user = try? decoder.decode(User.self, from: data) else {
                    self?.delegate?.didFindError(description: "Serialization error")
                    return
                }
                self?.user = user
                self?.delegate?.didUpdateData()
            } else if let error = error {
                self?.delegate?.didFindError(description: error.localizedDescription)
            } else {
                self?.delegate?.didFindError(description: "Unexpected Error")
            }
        }
    }
    
    var userName: String? {
        return self.user?.name
    }
    
    var company: String? {
        guard let company = self.user?.company else {
            return nil
        }
        return "@\(company)"
    }
    
    var location: String? {
        return self.user?.location
    }
    
    var email: String? {
        return self.user?.email
    }
    
    var bio: String? {
        return self.user?.bio
    }
    
    var twitterUsername: String? {
        return self.user?.twitterUsername
    }
    
    var followersCount: String? {
        let count = self.user?.followers ?? 0
        return String(count)
    }
    
    var followingCount: String? {
        let count = self.user?.following ?? 0
        return String(count)
    }
    
}
