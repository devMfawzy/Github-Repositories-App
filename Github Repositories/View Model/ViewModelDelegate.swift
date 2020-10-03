//
//  RepoModelDelegate.swift
//  Github Repositories
//
//  Created by Mohamed Fawzy on 10/2/20.
//  Copyright © 2020 fuzzix. All rights reserved.
//

import Foundation

protocol ViewModelDelegate: class {
    func didUpdateData()
    func willFetchData()
}
