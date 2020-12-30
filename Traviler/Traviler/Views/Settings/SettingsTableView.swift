//
//  SettingsTableView.swift
//  Traviler
//
//  Created by Mohammed Iskandar on 30/12/2020.
//

import UIKit

class SettingsTableView: UIView {
    
    var tableView: UITableView? {
        didSet {
            self.setupTableView()
        }
    }
    
    func setupTableView() {
        guard let tableView = self.tableView else { return }
        
        tableView.backgroundColor = .clear
        self.addSubview(tableView)
        tableView.setConstraints([
            .horizontal(padding: 0),
            .vertical(padding: 0)
        ])
    }
    
}
