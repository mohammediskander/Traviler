//
//  DiscoverMapController.swift
//  Traviler
//
//  Created by Mohammed Iskandar on 22/12/2020.
//

import UIKit
import MapKit

class DiscoverMapController: UIViewController, MKMapViewDelegate {
    
    var autoCompleteDataSource = CityDataSource.shared
    lazy var autoCompleteData = autoCompleteDataSource.filtered(with: nil)
    var autoCompleteController = AutoCompleteController()
    
    override func loadView() {
        self.view = MapView(textfieldValue: nil)
        
        let mapView = self.view as! MKMapView
        mapView.delegate = self
        
        if let mapView = self.view as? MapView {
            mapView.searchTextValue = nil
            mapView.searchTextfield?.delegate = self
            
            self.autoCompleteController.dataSource = CityDataSource.shared.data
            
            self.autoCompleteController.delegate = self
            
            
            self.addChild(self.autoCompleteController)
            mapView.autoCompleteView = self.autoCompleteController.view
        }
    }
    
//    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
//        if let mapView = self.view as? MapView {
//            mapView.searchTextfield?.resignFirstResponder()
//        }
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
}

extension DiscoverMapController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let mapView = self.view as? MapView {
            
            mapView.searchTextfield?.alpha = 1
            mapView.autoCompleteView?.isHidden = false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let mapView = self.view as? MapView {
            mapView.searchTextfield?.alpha = 0.7
            mapView.autoCompleteView?.isHidden = true
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        var text = (textField.text ?? "") + string
        
        if string == "" {
            text = String(text.dropLast())
        }
        
        self.autoCompleteData = self.autoCompleteDataSource.filtered(with: text)
        self.autoCompleteController.dataSource = self.autoCompleteData
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension DiscoverMapController: AutoCompleteDelegate {
    func autoCompleteDidUpdate(_ view: AutoCompleteView, height: CGFloat) {
        if let mapView = self.view as? MapView {
            mapView.updateAutoCompleteHeight(by: height)
        }
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        if let mapView = self.view as? MapView {
            mapView.setRegion(MKCoordinateRegion(center: self.autoCompleteData[indexPath.row].coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)), animated: true)
            mapView.searchTextfield?.resignFirstResponder()
        }
    }
}
