//
//  RepoViewCell.swift
//  Github Repositories
//
//  Created by Mohamed Fawzy on 10/3/20.
//  Copyright © 2020 fuzzix. All rights reserved.
//

import UIKit
import SDWebImage

class RepoViewCell: UITableViewCell {

    static let identifier = "RepoViewCell"
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var ownerNameLabel: UILabel!
    
    func config(repoName: String?, ownerName: String?, avatarUrl: String?) {
        self.repoNameLabel.text = repoName
        self.ownerNameLabel.text = ownerName
        if let avatarUrl = avatarUrl {
            self.avatar.sd_setImage(with: URL(string: avatarUrl), placeholderImage: #imageLiteral(resourceName: "placeholder"))
        }
    }
    
}
