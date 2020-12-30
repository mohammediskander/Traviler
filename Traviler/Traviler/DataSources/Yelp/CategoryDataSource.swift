//
//  CategoryDataSource.swift
//  Traviler
//
//  Created by Mohammed Iskandar on 25/12/2020.
//

import Foundation

protocol CategoriesDataSourceDelegate: DataSourceDelegate {

}

class CategoriesDataSource: NSObject, DataSource {
    
    var saved: Bool! = false
    
    var dataArchiveFileName: String! = "categories.json"
    
    typealias DataType = YelpCategory?
    typealias DecodeType = YelpCategoryResponse
    
    static var shared: CategoriesDataSource? = .init()
    var delegate: DataSourceDelegate?
    
    var imageStore: ImageStore? = nil
    
    var data: [DataType] = [] {
        didSet {
//            self.dataSource(data, didUpdateFrom: oldValue)
            self.delegate?.handleDataSource(data, didUpdatFrom: oldValue)
            try? self.jsonIO.write(self.data, to: self.fileURL)
        }
    }
    
    var fetcher: ImageFetcher = ImageFetcher()
    var requests: [IndexPath : ImageFetchingRequest] = [:]
    
    var endpoint: Router = FoursquareRouter.getVenueCategoires
    
    lazy var fileURL: URL = {
        return BusinessDataStore.documentDirectoryURL!.appendingPathComponent(self.dataArchiveFileName)
    }()
    
    let jsonIO = JSONIO()
    
    convenience init(forEndpoint endpoint: Router) {
        self.init()
        
        self.jsonIO.read(from: self.fileURL, decodeType: [DataType].self, complection: {
            result in
            
            switch result {
            case .success(let decodedData):
                self.data = decodedData
            
            case .failure(let error):
                print("ERR::\(error)")
            }
        })

        self.endpoint = endpoint

        self.fetch(self.endpoint) {
            [weak self] result in

            switch result {
            case .success(let yelpResponse):
                guard let self = self else { return }
                guard let categories = yelpResponse.categories else { return }
                
                var filteredCategories: [YelpCategory] = []
                for category in categories where category.parentAliases?.count == 0 {
                    filteredCategories.append(category)
                }
                
                OperationQueue.main.addOperation {
                    self.data = filteredCategories
                }
                
            case .failure(let error):
                print("ERR::\(error)")
                break
            }
        }
    }
    
}
