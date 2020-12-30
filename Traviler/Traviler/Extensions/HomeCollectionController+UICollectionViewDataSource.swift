//
//  HomeCollectionController+UICollectionViewDataSource.swift
//  Traviler
//
//  Created by Mohammed Iskandar on 25/12/2020.
//

import UIKit

enum CellIdentifiers: String {
    case largeCell
    case regularCell
}

enum HeaderIdentifier: String {
    case text
    case textfield
}

extension HomeCollectionController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.categoriesDataSource.data.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return self.businessDataSource.data.count
        default:
            
            return 4
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.largeCell.rawValue, for: indexPath) as! HomeLargeCell
            
            cell.business = nil
            cell.update(displaying: nil)
            
            if self.businessDataSource.data.count != 0 {
                cell.business = self.businessDataSource.data[indexPath.row]
            }
            
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.regularCell.rawValue, for: indexPath) as! HomeRegularCell
            
            cell.business = nil
            cell.update(displaying: nil)
            
            guard let category = self.categoriesDataSource.data[indexPath.section - 1] ?? nil else { return cell }
            guard let section = self.businessDataSource.sectionData[category.alias!] else { return cell}
            
            if section.count != 0 {
                cell.business = section[indexPath.row]
            }
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch indexPath.section {
        case 0:
            
            switch kind {
            case "headerKind":
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderIdentifier.text.rawValue, for: indexPath) as! HomeTextHeader
                header.text = "Recommendation"
                header.seeAllButton.isHidden = true
                
                return header
            default:
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderIdentifier.textfield.rawValue, for: indexPath) as! HomeTextFieldHeader
                header.text = "Looking for something?"
                header.textfield.delegate = self
                
                return header
            }
        default:
            
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderIdentifier.text.rawValue, for: indexPath) as! HomeTextHeader
            guard let category = self.categoriesDataSource.data[indexPath.section - 1] ?? nil else { return header }
            
            header.text = category.title
            header.seeAllButton.tag = indexPath.section - 1
            header.seeAllButton.addTarget(self, action: #selector(self.handleSeeAllButtonTapped), for: .touchUpInside)
            header.seeAllButton.isHidden = false
            
            return header
        }
    }
    
    @objc func handleSeeAllButtonTapped(_ sender: UIButton) {
        let category = self.categoriesDataSource.data[sender.tag]!
        let listController = ListController()
        listController.listTitle = category.title
        guard let section = self.businessDataSource.sectionData[category.alias!] else { return }
        listController.dataSource = section
        
        self.navigationController?.pushViewController(listController, animated: true)
    }
}

extension HomeCollectionController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        self.tabBarController?.selectedViewController = self.tabBarController?.viewControllers![1]
        
        let discoverNavigationController = self.tabBarController?.viewControllers![1] as! UINavigationController
        discoverNavigationController.popToRootViewController(animated: false)
        
        let discoverController = discoverNavigationController.topViewController as! DiscoverController
        discoverController.navigateToMapController(with: nil)
    }
}
