//
//  HomeController.swift
//  Traviler
//
//  Created by Mohammed Iskandar on 19/12/2020.
//

import UIKit

class HomeController: UIViewController {
    override func loadView() {
        
        self.view = HomeView()
        self.view.backgroundColor = Style.Colors.backgroundColor
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.backItem?.backButtonTitle = "Home"
        
        if let homeView = self.view as? HomeView {
            let collectionView = HomeCollectionController()
            self.addChild(collectionView)

            homeView.collectionView = collectionView.view
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.title = "Great Evening"
    }
}
