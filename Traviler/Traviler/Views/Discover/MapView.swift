//
//  MapView.swift
//  Traviler
//
//  Created by Mohammed Iskandar on 22/12/2020.
//

import UIKit
import MapKit

class MapView: MKMapView {
    
    var tapView = UIView()
    var searchTextValue: String? {
        didSet {
            self.setupSearchTextfield(searchValue: searchTextValue)
        }
    } 
    var searchTextfield: TextField?
    var autoCompleteView: UIView? {
        didSet {
            self.setupAutoCompleteView()
        }
    }
    var autoCompleteViewHeightConstraint: NSLayoutConstraint?
    
    init(textfieldValue: String? = nil) {
        self.init()
    }
    
    func setupAutoCompleteView() {
        self.addSubview(self.autoCompleteView!)
        
        self.autoCompleteView?.setConstraints([
            .top(padding: 10, from: self.searchTextfield?.bottomAnchor),
            .horizontal(padding: 14),
        ])
        self.autoCompleteViewHeightConstraint = self.autoCompleteView?.heightAnchor.constraint(equalToConstant: 0)
        self.autoCompleteViewHeightConstraint?.isActive = true
    }
    
    func updateAutoCompleteHeight(by height: CGFloat) {
        self.autoCompleteViewHeightConstraint?.constant = height
    }
    
    func setupSearchTextfield(searchValue: String?) {
        self.searchTextfield = TextField(searchValue, placeholder: "Search", borderColor: Style.Colors.secondayColor.cgColor)
        self.searchTextfield?.textContentType = .addressCity
        
        if searchValue == nil {
            self.searchTextfield?.becomeFirstResponder()
        }
        
        self.addSubview(searchTextfield!)
        
        self.searchTextfield?.setConstraints([
            .top(padding: 10, from: self.superview?.topAnchor),
            .horizontal(padding: 14),
            .height(40)
        ])
        
        self.searchTextfield?.backgroundColor = Style.Colors.backgroundColor
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
