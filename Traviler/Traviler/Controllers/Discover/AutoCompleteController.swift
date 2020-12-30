//
//  AutoCompleteController.swift
//  Traviler
//
//  Created by Mohammed Iskandar on 23/12/2020.
//

import UIKit

protocol AutoCompleteDelegate: AnyObject {
    func didSelectRow(at: IndexPath)
    func autoCompleteDidUpdate(_ view: AutoCompleteView, height: CGFloat)
}

class AutoCompleteController: UIViewController {
    
    lazy var tableView = UITableView()
    var dataSource: [City]! {
        didSet {
            tableView.reloadData()
            if let autoCompleteView = self.view as? AutoCompleteView {
                autoCompleteView.updateTableViewHeight()
                autoCompleteView.delegate = self
            }
        }
    }
    weak var delegate: AutoCompleteDelegate?
    
    private let autoCompleteCell = "autoCompleteCell"
    
    override func loadView() {
//        self.tableView =
        
        self.view = AutoCompleteView(tableView)
        tableView.allowsSelection = true
//        tableView.register(UITableViewCell.self, forCellWithReuseIdentifier: self.autoCompleteCell)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: self.autoCompleteCell)
//        tableView.alwaysBounceHorizontal = false
        self.tableView.separatorStyle = .none
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = .clear
        self.tableView.allowsSelection = true
        self.tableView.allowsMultipleSelection = false
        self.tableView.delaysContentTouches = false
        self.tableView.isUserInteractionEnabled = true
    }
}

extension AutoCompleteController: AutoCompleteViewDelegate {
    func autoCompleteView(didUpdate height: CGFloat) {
        self.delegate?.autoCompleteDidUpdate(self.view as! AutoCompleteView, height: height)
    }
}

extension AutoCompleteController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.autoCompleteCell)!
        
        cell.textLabel?.text = dataSource[indexPath.row].name
        cell.backgroundColor = Style.Colors.backgroundColor

        return cell
    }
}

extension AutoCompleteController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.didSelectRow(at: indexPath)
    }
}
