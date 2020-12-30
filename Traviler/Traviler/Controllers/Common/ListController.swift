//
//  ListController.swift
//  Traviler
//
//  Created by Mohammed Iskandar on 28/12/2020.
//

import UIKit

class ListController: UIViewController {
    
    var dataSource: [Business]!
    var listTitle: String!
    var dataIndexPath: Int?
    var isCategoryList: Bool! = false
    
    override func loadView() {
        self.view = ListView()
        
        self.view.backgroundColor = Style.Colors.backgroundColor
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        if let listView = view as? ListView {
            let collectionView = ListCollectionViewController()
            collectionView.dataSource = self.dataSource
            self.addChild(collectionView)
            
            listView.collectionView = collectionView.view
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = self.listTitle
    }
}
