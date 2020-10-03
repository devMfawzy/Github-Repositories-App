//
//  ReposoteriesResponse.swift
//  Github Repositories
//
//  Created by Mohamed Fawzy on 10/2/20.
//  Copyright © 2020 fuzzix. All rights reserved.
//

import Foundation

struct Repository: Decodable {
    let id: Int
    var name: String
    var owner: Owner?
}
