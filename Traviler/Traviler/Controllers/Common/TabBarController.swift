//
//  TabBarViewController.swift
//  Traviler
//
//  Created by Mohammed Iskandar on 20/12/2020.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let homeTab = UINavigationController(rootViewController: HomeController())
        let homeBarItem = UITabBarItem(title: String(), image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        homeTab.tabBarItem = homeBarItem
        
        let discoverTab = UINavigationController(rootViewController: DiscoverController())
        let discoverBarItem = UITabBarItem(title: String(), image: UIImage(systemName: "magnifyingglass"), selectedImage: UIImage(systemName: "magnifyingglass"))
        discoverTab.tabBarItem = discoverBarItem
        
//        let favouritsController = ListController()
//        favouritsController.dataSource = BusinessDataStore.shared?.dumpData["favourits"] ?? []
//        favouritsController.listTitle = "Favouries"
        
        let favouritTab = UINavigationController(rootViewController: FavouritesController())
        let favouritBarItem = UITabBarItem(title: String(), image: UIImage(systemName: "star"), selectedImage: UIImage(systemName: "star.fill"))
        favouritTab.tabBarItem = favouritBarItem
        
        let visitListTab = UINavigationController(rootViewController: VisitListController())
        let visitListBarItem = UITabBarItem(title: String(), image: UIImage(systemName: "list.dash"), selectedImage: UIImage(systemName: "list.dash"))
        visitListTab.tabBarItem = visitListBarItem
        
        let settingsTab = UINavigationController(rootViewController: SettingsController())
        let settingsBarItem = UITabBarItem(title: String(), image: UIImage(systemName: "gearshape"), selectedImage: UIImage(systemName: "gearshape.fill"))
        settingsTab.tabBarItem = settingsBarItem
        
        
        self.viewControllers = [homeTab, discoverTab, favouritTab, visitListTab, settingsTab]
    }
    
}
