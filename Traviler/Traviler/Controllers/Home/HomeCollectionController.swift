//
//  HomeCollectionViewController.swift
//  Traviler
//
//  Created by Mohammed Iskandar on 20/12/2020.
//

import UIKit
import CoreLocation

class HomeCollectionController: UIViewController {
    
    var collectionView: UICollectionView!
    
    private static var headerKind = "headerKind"
    private static var footerKind = "footerKind"
    
    var businessDataSource = BusinessDataStore.shared!
    var categoriesDataSource = CategoriesDataSource.shared!
    
    override func loadView() {
        BusinessDataStore.shared = self.businessDataSource
        let homeCollectionView = HomeCollectionView()
        self.view = homeCollectionView
        
        self.collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: self.createLayout())
        homeCollectionView.collectionView = self.collectionView
        
        collectionView.register(HomeLargeCell.self, forCellWithReuseIdentifier: CellIdentifiers.largeCell.rawValue)
        collectionView.register(HomeRegularCell.self, forCellWithReuseIdentifier: CellIdentifiers.regularCell.rawValue)
        
        collectionView.register(
            HomeTextHeader.self,
            forSupplementaryViewOfKind: HomeCollectionController.headerKind,
            withReuseIdentifier: HeaderIdentifier.text.rawValue
        )
        
        collectionView.register(
            HomeTextFieldHeader.self,
            forSupplementaryViewOfKind: HomeCollectionController.headerKind,
            withReuseIdentifier: HeaderIdentifier.textfield.rawValue
        )
        
        collectionView.register(
            HomeTextFieldHeader.self,
            forSupplementaryViewOfKind: HomeCollectionController.footerKind,
            withReuseIdentifier: HeaderIdentifier.textfield.rawValue
        )
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        
        businessDataSource.delegate = self
        categoriesDataSource.delegate = self
    }
    
    func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout {
            (section, environment) -> NSCollectionLayoutSection in
            
            switch section {
            case 0:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets.bottom = 5
                item.contentInsets.leading = 5
                item.contentInsets.trailing = 5
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4), heightDimension: .estimated(250))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets.leading = 14
                section.contentInsets.trailing = 14
                section.orthogonalScrollingBehavior = .groupPaging
                
                section.boundarySupplementaryItems = [
                    .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(62)), elementKind: HomeCollectionController.headerKind, alignment: .topLeading),
                    .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(62)), elementKind: HomeCollectionController.footerKind, alignment: .bottom)
                ]
                
                return section
                
            default:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets.bottom = 5
                item.contentInsets.leading = 5
                item.contentInsets.trailing = 5
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.586666667), heightDimension: .estimated(148))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets.leading = 14
                section.contentInsets.trailing = 14
                section.orthogonalScrollingBehavior = .groupPaging
                
                section.boundarySupplementaryItems = [
                    .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(58)), elementKind: HomeCollectionController.headerKind, alignment: .topLeading)
                ]
                
                return section
            }
            
        }
    }
}

extension HomeCollectionController: DataSourceDelegate {
    func handleDataSource<T>(_ data: [T], didUpdatFrom oldValue: [T]?) {
        self.collectionView.reloadData()
    }
}
