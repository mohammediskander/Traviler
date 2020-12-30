//
//  AutoCompleteView.swift
//  Traviler
//
//  Created by Mohammed Iskandar on 23/12/2020.
//

import UIKit

protocol AutoCompleteViewDelegate: AnyObject {
    func autoCompleteView(didUpdate height: CGFloat)
}

class AutoCompleteView: UIView {
    
    weak var delegate: AutoCompleteViewDelegate?
    
    var tableView: UITableView? {
        didSet {
            self.addSubview(self.tableView!)
            self.tableView?.setConstraints([
                .horizontal(padding: 0),
                .vertical(padding: 0)
            ])
        }
    }
    
    private var tableViewHeightConstraint: NSLayoutConstraint!
    
    init(_ view: UITableView) {
        self.init()
        
        self.tableView = view
        self.tableView?.layer.cornerRadius = 6.25
        
        self.addSubview(self.tableView!)
        
        self.tableViewHeightConstraint = tableView?.heightAnchor.constraint(equalToConstant: 300)
        self.tableViewHeightConstraint.isActive = true
        self.tableView?.setConstraints([
            .horizontal(padding: 0)
        ])
    }
    
    
    func updateTableViewHeight() {
        if let height = (tableView?.contentSize.height)! > 300 ? 300 : tableView?.contentSize.height {
            self.tableViewHeightConstraint.constant = height
            self.delegate?.autoCompleteView(didUpdate: height)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
