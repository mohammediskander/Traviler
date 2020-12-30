//
//  SettingsController.swift
//  Traviler
//
//  Created by Mohammed Iskandar on 19/12/2020.
//

import UIKit

class SettingsController: UIViewController {
    override func loadView() {
        
        self.view = SettingsView()
        self.view.backgroundColor = Style.Colors.backgroundColor
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        if let settingsView = self.view as? SettingsView {
            let tableView = SettingsTableController()
            self.addChild(tableView)
            
            settingsView.tableView = tableView.view
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.title = "Settings"
    }
}
