//
//  UIExtension.swift
//  Plank ON
//
//  Created by 하동훈 on 2021/04/13.
//

import UIKit

extension UICollectionViewCell {
    // The @objc is added to silence the complier errors
    @objc class var identifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell {
    @objc class var identifier: String {
        return String(describing: self)
    }
}
