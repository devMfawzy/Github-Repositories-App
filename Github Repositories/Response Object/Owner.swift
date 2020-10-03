//
//  Owner.swift
//  Github Repositories
//
//  Created by Mohamed Fawzy on 10/2/20.
//  Copyright © 2020 fuzzix. All rights reserved.
//

import Foundation

struct Owner: Decodable {
    var login: String
    var avatarUrl: String
    var url: String?
}
