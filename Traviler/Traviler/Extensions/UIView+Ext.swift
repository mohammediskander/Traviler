//
//  UIView+Ext.swift
//  Todoiest
//
//  Created by Mohammed Iskandar on 08/12/2020.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views {
            self.addSubview(view)
        }
    }
}
