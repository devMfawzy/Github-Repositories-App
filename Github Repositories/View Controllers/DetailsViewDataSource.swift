//
//  DetailsViewDataSource.swift
//  Github Repositories
//
//  Created by Mohamed Fawzy on 10/2/20.
//  Copyright © 2020 fuzzix. All rights reserved.
//

import Foundation

protocol DetailsViewDataSource: class {
    
    func avatarUrl() -> String?
    func loginName() -> String?
    func repoName() -> String?
    func userUrl() -> String?
    
}
