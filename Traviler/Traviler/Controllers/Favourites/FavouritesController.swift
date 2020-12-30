//
//  FavouriteController.swift
//  Traviler
//
//  Created by Mohammed Iskandar on 19/12/2020.
//

import UIKit

class FavouritesController: UIViewController {
    override func loadView() {
        
        self.view = ListView()
        self.view.backgroundColor = Style.Colors.backgroundColor
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        if let listView = view as? ListView {
            let collectionView = FavourtiesCollectionController()
//            collectionView.dataSource = self.dataSource
            self.addChild(collectionView)
            
            listView.collectionView = collectionView.view
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.title = "Favourits"
    }
}
