//
//  HomeCollectionController+UICollectionViewDelegate.swift
//  Traviler
//
//  Created by Mohammed Iskandar on 26/12/2020.
//

import UIKit
import CoreLocation


extension HomeCollectionController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.businessDataSource.requests[indexPath]?.priority = .high
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        switch indexPath.section {
        
        case 0:
            var business = self.businessDataSource.data[indexPath.row]
            
            if business.weather == nil {
                let weatherOperation = OperationQueue()
                weatherOperation.addOperation {
                    URLSession.shared.fetch(
                        WeatherRouter.getCurrentWeather(at:
                                                        CLLocationCoordinate2D(latitude: business.coordinates!.latitude!, longitude: business.coordinates!.longitude!)
                        ),
                        decode: WeatherResponse.self
                    ) {
                        result in
                        
                        switch result {
                        case .success(let weatherResponse):
                            
                            business.weather = weatherResponse.current
                            self.businessDataSource.dumpData["recommended"]?[indexPath.row] = business
                            
                            OperationQueue.main.addOperation {
                                if let cell = collectionView.cellForItem(at: indexPath) as? HomeLargeCell {
                                    cell.update(displaying: weatherResponse.current!)
                                }
                            }
                        case .failure(let error):
                            print("ERR::\(error)")
                        }
                    }
                }
            }
            
            if let cell = cell as? HomeLargeCell, cell.imageSuspenseChildView?.image == nil {
                self.businessDataSource.fetch(imageFor: business, atIndexPath: indexPath) {
                    image in
                    
                    guard let businessIndex = self.businessDataSource.data.firstIndex(of: business) else { return }
                    let indexPath = IndexPath(row: businessIndex, section: indexPath.section)
                    
                    OperationQueue.main.addOperation {
                        if let cell = collectionView.cellForItem(at: indexPath) as? HomeLargeCell {
                            cell.update(displaying: image)
                        }
                    }
                    
                }
            }
            break
        default:
            if indexPath.row == 0 {
                if let category = self.categoriesDataSource.data[indexPath.section - 1] {
                    
                    
                    
                    if let section = self.businessDataSource.dumpData[category.alias!], self.businessDataSource.sectionData[category.alias!] == nil {
                        OperationQueue.main.addOperation {
                            self.businessDataSource.sectionData[category.alias!] = section
                        }
                    }
                    
                    self.businessDataSource.fetch(for: category) {
                        [weak self] result in
                        
                        switch result {
                        case .success(let categoryResponse):
                            guard let self = self else { return }
                            guard let businesses = categoryResponse.businesses else { return }
                            
                            if businesses.count != 0 {
                                self.businessDataSource.dumpData[category.alias!] = businesses
                            }
                            
                            OperationQueue.main.addOperation {
                                if businesses.count == 0 {
                                    self.categoriesDataSource.data.remove(at: indexPath.section - 1)
                                } else {
                                    if self.businessDataSource.sectionData[category.alias!] != nil {
                                        self.businessDataSource.sectionData[category.alias!] = businesses
                                    }
                                }
                            }
                        case .failure(let error):
                            print("ERR::\(error)")
                        }
                    }
                }
            }
            
            guard let category = self.categoriesDataSource.data[indexPath.section - 1] ?? nil else { return }
            guard let section = self.businessDataSource.sectionData[category.alias!], section.count != 0 else { return }
            
            var business = section[indexPath.row]
            
            if business.weather == nil {
                let weatherOperation = OperationQueue()
                weatherOperation.addOperation {
                    URLSession.shared.fetch(
                        WeatherRouter.getCurrentWeather(at:
                                                        CLLocationCoordinate2D(latitude: business.coordinates!.latitude!, longitude: business.coordinates!.longitude!)
                        ),
                        decode: WeatherResponse.self
                    ) {
                        result in
                        
                        switch result {
                        case .success(let weatherResponse):
                            
                            business.weather = weatherResponse.current
                            self.businessDataSource.dumpData[category.alias!]?[indexPath.row] = business
                            
                            OperationQueue.main.addOperation {
                                if let cell = collectionView.cellForItem(at: indexPath) as? HomeRegularCell {
                                    cell.update(displaying: weatherResponse.current!)
                                }
                            }
                        case .failure(let error):
                            print("ERR::\(error)")
                        }
                    }
                }
            }
            
            
            if let cell = cell as? HomeRegularCell, cell.imageSuspenseChildView?.image == nil {
                self.businessDataSource.fetch(imageFor: business, atIndexPath: indexPath) {
                    image in
                    
                    guard let businessIndex = section.firstIndex(of: business) else { return }
                    let indexPath = IndexPath(row: businessIndex, section: indexPath.section)
                    
                    OperationQueue.main.addOperation {
                        if let cell = collectionView.cellForItem(at: indexPath) as? HomeRegularCell {
                            cell.update(displaying: image)
                        }
                    }
                    
                }
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            let businessController = BusinessController()
            businessController.business = self.businessDataSource.data[indexPath.row]
            self.present(businessController, animated: true)
        default:
            
            guard let category = self.categoriesDataSource.data[indexPath.section - 1] ?? nil else { return }
            guard let section = self.businessDataSource.sectionData[category.alias!] else { return }
            
            let businessController = BusinessController()
            businessController.business = section[indexPath.row]
            
            self.present(businessController, animated: true)
        }
    }
    
}
