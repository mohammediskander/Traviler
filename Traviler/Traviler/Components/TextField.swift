//
//  TextField.swift
//  Traviler
//
//  Created by Mohammed Iskandar on 22/12/2020.
//

import UIKit

class TextField: UITextField {
    init(_ text: String? = nil, placeholder: String? = nil, borderColor: CGColor? = nil) {
        self.init()
        
        self.placeholder = placeholder
        self.text = text
        self.layer.cornerRadius = 6.25
        self.layer.borderWidth = 1
        self.layer.borderColor = borderColor
        
        // Left padding by 10pt
        self.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
