//
//  String+Ext.swift
//  Traviler
//
//  Created by Mohammed Iskandar on 21/12/2020.
//

import Foundation

extension String {
    static func `repeat`(_ char: String, times count: UInt) -> String {
        var repeatedString = ""
        
        for _ in 0..<count  {
            repeatedString = repeatedString + char
        }
        
        return repeatedString
    }
}
