//
//  HomeView.swift
//  Traviler
//
//  Created by Mohammed Iskandar on 19/12/2020.
//

import UIKit

class HomeView: UIView {
    var collectionView: UIView? {
        didSet {
            self.setupCollectionView()
        }
    }
    
    func setupCollectionView() {
        guard let collectionView = collectionView else {
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
