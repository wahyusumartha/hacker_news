//
//  UITableViewAdditions.swift
//  Boilerplate
//
//  Created by Khoi Truong Minh on 7/7/16.
//  Copyright © 2016 Innovatube. All rights reserved.
//

import UIKit

extension UITableView {

    func registerCellType<T: UITableViewCell>(type: T.Type) {
        let className = String(T)
        let nib = UINib(nibName: className, bundle: nil)
        registerNib(nib, forCellReuseIdentifier: className)
    }

    func registerCellTypes<T: UITableViewCell>(types: [T.Type]) {
        for type in types {
            registerCellType(type)
        }
    }

    func dequeueReusableCellOfType<T: UITableViewCell>(type: T.Type) -> T? {
        let reuseIdentifier = String(T)
        let cell = dequeueReusableCellWithIdentifier(reuseIdentifier) as? T
        return cell
    }

}
