//
//  Bool+Ext.swift
//  Traviler
//
//  Created by Mohammed Iskandar on 24/12/2020.
//

import Foundation

extension Bool {
    var numeric: Int {
        if self {
            return 1
        } else {
            return 0
        }
    }
}
