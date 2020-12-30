//
//  SettingsTableController.swift
//  Traviler
//
//  Created by Mohammed Iskandar on 30/12/2020.
//

import UIKit

class SettingsTableController: UIViewController {

    var tableView: UITableView!
    
    var cells: [String] = [
        "Clear image cache",
        "Favouries businesses",
        "Visits Lists businesses"
    ]
    
    override func loadView() {
        let settingsTableView = SettingsTableView()
        self.view = settingsTableView
        
        self.tableView = UITableView(frame: self.view.bounds, style: .insetGrouped)
        settingsTableView.tableView = tableView
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    private var defaultCell = "defaultCell"
    
}


extension SettingsTableController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            ImageStore.shared.clear()
            
        default:
            break
        }
    }
}

extension SettingsTableController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: self.defaultCell)
        
        cell.textLabel?.text = self.cells[indexPath.row]
        cell.backgroundColor = Style.Colors.secondaryBackgroundColor
        
        
        switch indexPath.row {

        case 0:
            cell.detailTextLabel?.text = "\(String(format: "%.2f", ImageStore.shared.fileSizeOfCache())) MB"
        default:
            break
        }
        
        
        return cell
    }
}
