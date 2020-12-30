//
//  Int.swift
//  Traviler
//
//  Created by Mohammed Iskandar on 24/12/2020.
//

import Foundation

extension Array where Element == Int {
    func strinifyJoined(seperator: String) -> String {
        self.map { "\($0)" }.joined(separator: seperator)
    }
}
