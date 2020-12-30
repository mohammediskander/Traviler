//
//  VisitsListCollectionController.swift
//  Traviler
//
//  Created by Mohammed Iskandar on 30/12/2020.
//

import UIKit
import CoreLocation

enum VisitsListCellIdentifier: String {
    case `default`
}

class VisitsListCollectionController: UIViewController {
    
    var collectionView: UICollectionView!
    
    override func loadView() {
        let listCollectionView = ListCollectionView()
        self.view = listCollectionView
        
        self.collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: createLayout())
        
        listCollectionView.collectionView = collectionView
        
        collectionView.register(ListCell.self, forCellWithReuseIdentifier: FavourtiesCellIdentifier.default.rawValue)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.collectionView.reloadData()
    }
    
    func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout {
            (section, enviornment) -> NSCollectionLayoutSection in
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.49), heightDimension: .absolute(120))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets.bottom = 5
            item.contentInsets.leading = 5
            item.contentInsets.trailing = 5
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.2))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets.leading = 14
            section.contentInsets.trailing = 14
            
            return section
        }
    }
    
}

extension VisitsListCollectionController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        (BusinessDataStore.shared?.dumpData["visitsList"] ?? []).count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.default.rawValue, for: indexPath) as! ListCell
        
        cell.business = nil
        cell.update(displaying: nil)
        
        cell.business = (BusinessDataStore.shared?.dumpData["visitsList"] ?? [])![indexPath.row]
        
        return cell
    }
}

extension VisitsListCollectionController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let business = (BusinessDataStore.shared?.dumpData["visitsList"] ?? [])[indexPath.row]
        
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
                        OperationQueue.main.addOperation {
                            if let cell = collectionView.cellForItem(at: indexPath) as? ListCell {
                                cell.update(displaying: weatherResponse.current!)
                            }
                        }
                    case .failure(let error):
                        print("ERR::\(error)")
                    }
                }
            }
        }
        
        BusinessDataStore.shared!.fetch(imageFor: business, atIndexPath: indexPath) {
            image in
            
            guard let cell = cell as? ListCell else { return }
            cell.update(displaying: image)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let business = (BusinessDataStore.shared?.dumpData["visitsList"] ?? [])[indexPath.row]
        
        let businessController = BusinessController()
        businessController.business = business
        self.present(businessController, animated: true)
    }
}
