//
//  BussinessController.swift
//  Traviler
//
//  Created by Mohammed Iskandar on 20/12/2020.
//

import UIKit

class BusinessController: UIViewController {
    
    var business: Business!
    
    override func loadView() {
        let bunsinessView = BusinessView()
        bunsinessView.business = business
        bunsinessView.delegate = self
        
        self.view = bunsinessView
    }
    
}

extension BusinessController: BusinessViewDelegate {
    func handleOptionButtonTapped(_ sender: UIButton) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        if BusinessDataStore.shared?.dumpData["favourits"] == nil {
            BusinessDataStore.shared?.dumpData["favourits"] = []
        }
        
        if BusinessDataStore.shared?.dumpData["visitsList"] == nil {
            BusinessDataStore.shared?.dumpData["visitsList"] = []
        }
        
        let inFavourits = BusinessDataStore.shared?.dumpData["favourits"]!.contains(self.business)
        let inVistisList = BusinessDataStore.shared?.dumpData["visitsList"]!.contains(self.business)
        
        let favouritsAlertStyle: UIAlertAction.Style
        let favouritsAlertTitle: String
        
        if inFavourits! {
            favouritsAlertStyle = .destructive
            favouritsAlertTitle = "Remove from Favourits"
        } else {
            favouritsAlertStyle = .default
            favouritsAlertTitle = "Add to Favourits"
        }
        
        let addToFavouritAction = UIAlertAction(title: favouritsAlertTitle, style: favouritsAlertStyle) {
            _ in
            if inFavourits! {
                BusinessDataStore.shared?.dumpData["favourits"]?.removeAll(where: { (business) -> Bool in
                    business == self.business
                })
            } else {
                BusinessDataStore.shared?.dumpData["favourits"]?.append(self.business)
            }
        }
        alertController.addAction(addToFavouritAction)
        
        let visitsListAlertStyle: UIAlertAction.Style
        let visitsListAlertTitle: String
        
        if inVistisList! {
            visitsListAlertStyle = .destructive
            visitsListAlertTitle = "Remove from Visits List"
        } else {
            visitsListAlertStyle = .default
            visitsListAlertTitle = "Add to Visits List"
        }
        
        let addToVisitListAction = UIAlertAction(title: visitsListAlertTitle, style: visitsListAlertStyle) {
            _ in
            if inVistisList! {
                BusinessDataStore.shared?.dumpData["visitsList"]?.removeAll(where: { (business) -> Bool in
                    business == self.business
                })
            } else {
                BusinessDataStore.shared?.dumpData["visitsList"]?.append(self.business)
            }
        }
        alertController.addAction(addToVisitListAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}
