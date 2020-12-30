//
//  HomeTextHeader.swift
//  Traviler
//
//  Created by Mohammed Iskandar on 20/12/2020.
//

import UIKit

class HomeTextHeader: UICollectionReusableView {
    
    var text: String? {
        set {
            self.seeAllButton.setTitle("See all", for: .normal)
            self.seeAllButton.setTitleColor(Style.Colors.secondayColor, for: .normal )
            addSubviews(self.header, self.seeAllButton)
            self.header.text = newValue
            
            self.seeAllButton.setConstraints([
                .trailing(padding: 4, from: nil),
                .yAxis(padding: 0, from: self.header.centerYAnchor),
                .width(40)
            ])
            
            self.seeAllButton.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .regular)
            self.seeAllButton.titleLabel?.textAlignment = .left
            
            self.header.setConstraints([
                .leading(padding: 4, from: nil),
                .trailing(padding: 5, from: self.seeAllButton.leadingAnchor),
                .bottom(padding: 10, from: nil)
            ])
            
            
        }
        
        get {
            return self.header.text
        }
    }
    
    private var header = Text("", size: 26, weight: .bold)
    var seeAllButton = UIButton()
}
