//
//  Section.swift
//  Traviler
//
//  Created by Mohammed Iskandar on 21/12/2020.
//

import UIKit

class SectionView: UIView {
    
    var headerLabel: Text!
    var contentView: SuspenseView!
    
    convenience init(header headerText: String, view contentView: SuspenseView) {
        self.init()
        
        self.headerLabel = Text(headerText, size: 22, weight: .bold)
        self.contentView = contentView
        
        self.addSubviews(self.headerLabel, self.contentView)
        self.headerLabel.setConstraints([
            .top(padding: 0, from: nil),
            .leading(padding: 14, from: nil)
        ])
        self.contentView.setConstraints([
            .top(padding: 10, from: self.headerLabel.bottomAnchor),
            .bottom(padding: 0, from: nil),
            .horizontal(padding: 0)
        ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("\(#function) is not implemented.")
    }
}
