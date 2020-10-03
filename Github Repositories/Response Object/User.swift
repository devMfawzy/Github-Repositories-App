//
//  User.swift
//  Github Repositories
//
//  Created by Mohamed Fawzy on 10/3/20.
//  Copyright © 2020 fuzzix. All rights reserved.
//

import Foundation

struct User: Decodable {
    
    var name: String?
    var company: String?
    var location: String?
    var email: String?
    var bio: String?
    var twitterUsername: String?
    var followers: Int?
    var following: Int?
    
}
