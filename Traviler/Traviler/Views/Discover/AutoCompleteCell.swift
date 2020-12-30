//
//  AutoCompleteCell.swift
//  Traviler
//
//  Created by Mohammed Iskandar on 23/12/2020.
//

import UIKit

class AutoCompleteCell: UICollectionViewCell {
    
    var text: String? = ""
    
    var name: Text? = nil
    
    override func layoutSubviews() {
        self.name = Text(text!)
        self.contentView.addSubview(name!)
        self.name?.setConstraints([
            .vertical(padding: 0),
            .leading(padding: 10, from: nil)
        ])
    }
}
