//
//  DiscoverController.swift
//  Traviler
//
//  Created by Mohammed Iskandar on 19/12/2020.
//

import UIKit

class DiscoverController: UIViewController {
    override func loadView() {
        self.view = ListView()
        
        self.view.backgroundColor = Style.Colors.backgroundColor
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        self.tabBarItem.title = "Discover"
        
        if let listView = view as? ListView {
            let collectionView = ListCollectionViewController()
            self.addChild(collectionView)
            
            listView.collectionView = collectionView.view
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Discover"
    }
    
    func navigateToMapController(with textFieldValue: String?) {
        
        let discoverMapController = DiscoverMapController()
        self.navigationController?.pushViewController(discoverMapController, animated: true)
    }
}
