//
//  HomeTextFieldHeader.swift
//  Traviler
//
//  Created by Mohammed Iskandar on 20/12/2020.
//

import UIKit

class HomeTextFieldHeader: UICollectionReusableView {
    
    var text: String? {
        set {
            self.textfield = TextField(placeholder: newValue, borderColor: Style.Colors.secondayColor.cgColor)
            addSubview(self.textfield)
            
            self.textfield.setConstraints([
                .height(40),
                .center,
                .horizontal(padding: 4)
            ])
        }
        
        get {
            return self.textfield.placeholder
        }
    }
    
    private(set) var textfield: TextField!
}
