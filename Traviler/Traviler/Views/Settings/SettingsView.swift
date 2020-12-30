//
//  SettingsView.swift
//  Traviler
//
//  Created by Mohammed Iskandar on 30/12/2020.
//

import UIKit

class SettingsView: UIView {
    
    var tableView: UIView? {
        didSet {
            self.setupCollectionView()
        }
    }
    
    func setupCollectionView() {
        guard let collectionView = tableView else {
            return
        }
        
        self.addSubview(collectionView)
        collectionView.setConstraints([
            .horizontal(padding: 0),
            .top(padding: 0, from: nil),
            .bottom(padding: 0, from: self.layoutMarginsGuide.bottomAnchor)
        ])
    }
}
