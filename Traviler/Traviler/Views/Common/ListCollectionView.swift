//
//  ListCollectionView.swift
//  Traviler
//
//  Created by Mohammed Iskandar on 20/12/2020.
//

import UIKit

class ListCollectionView: UIView {
    var collectionView: UICollectionView? {
        didSet {
            self.setupCollectionView()
        }
    }
    
    func setupCollectionView() {
        guard let collectionView = collectionView else {
            return
        }
        
        collectionView.backgroundColor = .clear
        self.addSubview(collectionView)
        collectionView.setConstraints([
            .horizontal(padding: 0),
            .vertical(padding: 0)
        ])
    }
}
