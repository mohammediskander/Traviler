//
//  Text.swift
//  Traviler
//
//  Created by Mohammed Iskandar on 21/12/2020.
//

import UIKit

class Text: UILabel {
    
    convenience init(_ text: String, color: UIColor = .label, size: CGFloat = 16, weight: UIFont.Weight = .regular) {
        self.init()
        
        self.text = text
        self.font = UIFont.systemFont(ofSize: size, weight: weight)
        self.textColor = color
    }
    
}
