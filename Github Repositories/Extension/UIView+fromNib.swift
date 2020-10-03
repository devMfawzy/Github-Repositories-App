//
//  UIView+fromNib.swift
//  Github Repositories
//
//  Created by Mohamed Fawzy on 10/3/20.
//  Copyright © 2020 fuzzix. All rights reserved.
//

import UIKit

public protocol NibIdentifiable {
    static var nibNameIdentifier: String { get }
}

extension NibIdentifiable {
    
    public static var nibNameIdentifier: String {
        let fullName: String = String(describing: self)
        let nibIdentifie = fullName.prefix(while: { $0 != "<"} )
        return String(nibIdentifie)
    }
    
}

extension UIView : NibIdentifiable { }

extension NibIdentifiable where Self: UIView {
    
    public static func fromNib() -> Self {
        let nib = UINib(nibName: Self.nibNameIdentifier, bundle: nil)
        return nib.instantiate(withOwner: nil, options: nil)[0] as! Self
    }
    
}
