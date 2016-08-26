//
//  UICollectionViewAdditions.swift
//  Boilerplate
//
//  Created by Khoi Truong Minh on 7/9/16.
//  Copyright © 2016 Innovatube. All rights reserved.
//

import UIKit

extension UICollectionView {

    func registerCellType<T: UICollectionViewCell>(type: T.Type) {
        let className = String(T)
        let nib = UINib(nibName: className, bundle: nil)
        registerNib(nib, forCellWithReuseIdentifier: className)
    }

    func registerCellTypes<T: UICollectionViewCell>(types: [T.Type]) {
        for type in types {
            registerCellType(type)
        }
    }

    func registerHeaderViewOfType<T: UICollectionReusableView>(type: T.Type) {
        let className = String(T)
        let nib = UINib(nibName: className, bundle: nil)
        let kind = UICollectionElementKindSectionHeader
        registerNib(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: className)
    }

    func registerFooterViewOfType<T: UICollectionReusableView>(type: T.Type) {
        let className = String(T)
        let nib = UINib(nibName: className, bundle: nil)
        let kind = UICollectionElementKindSectionFooter
        registerNib(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: className)
    }

    func dequeueReusableCellOfType<T: UICollectionViewCell>(type: T.Type, forIndexPath indexPath: NSIndexPath) -> T? {
        let reuseIdentifier = String(T)
        let cell = dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as? T
        return cell
    }

    func dequeueReusableSupplementaryViewOfType<T: UICollectionReusableView>(type: T.Type, kind: String, forIndexPath indexPath: NSIndexPath) -> T? {
        let reuseIdentifier = String(T)
        let header = dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: reuseIdentifier, forIndexPath: indexPath) as? T
        return header
    }

}
