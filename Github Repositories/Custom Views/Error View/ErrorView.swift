//
//  ErrorView.swift
//  Github Repositories
//
//  Created by Mohamed Fawzy on 10/3/20.
//  Copyright © 2020 fuzzix. All rights reserved.
//

import UIKit

class ErrorView: UIView {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    private var retryBlock: (()->Void)?
    
    @IBAction private func retryButton() {
        self.retryBlock?()
    }
    
    func onRetry(block: @escaping ()->Void) {
        self.retryBlock = block
    }
    
}
