//
//  BusinessDataStore.swift
//  Traviler
//
//  Created by Mohammed Iskandar on 26/12/2020.
//

import UIKit
import CoreLocation

class CategorySection {
    let category: YelpCategory
    var data: [Business] = []
    
    init(cateogry: YelpCategory) {
        self.category = cateogry
    }
}

class BusinessDataStore: NSObject, DataSource {
    var saved: Bool! = false
    
    var dataArchiveFileName: String! = "businesses.json"
    
    typealias DataType = Business
    typealias DecodeType = YelpSearchResponse
    
    static var shared: BusinessDataStore? = nil
    weak var delegate: DataSourceDelegate? = nil
    
    var imageStore: ImageStore? = ImageStore.shared
    
    var data: [DataType] = [] {
        didSet {
            self.delegate?.handleDataSource(self.data, didUpdatFrom: oldValue)
            self.dumpData["recommended"] = self.data
        }
    }
    
    var fetcher: ImageFetcher = ImageFetcher()
    var requests: [IndexPath : ImageFetchingRequest] = [:]
    
    var sectionData: [String: [DataType]] = [:]
    
    var dumpData: [String: [DataType]] = [:] {
        didSet {
            try? self.jsonIO.write(self.dumpData, to: self.fileURL)
        }
    }
    
    var endpoint: Router!
    lazy var fileURL: URL = {
        return BusinessDataStore.documentDirectoryURL!.appendingPathComponent(self.dataArchiveFileName)
    }()
    
    let jsonIO = JSONIO()
    
    convenience init(forEndpoint endpoint: Router) {
        self.init()
        
        self.jsonIO.read(from: self.fileURL, decodeType: [String: [DataType]].self, complection: {
            [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let decodedData):
                
                self.dumpData.merge(decodedData) {
                    current, _ in
                    
                    current
                }
                
                if let recommendedCache = self.dumpData["recommended"] {
                    self.data = recommendedCache
                }
            
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
                
                guard let businesses = yelpResponse.businesses else { return }
                
                
                OperationQueue.main.addOperation {
                    self.data = businesses
                }
                
            case .failure(let error):
                print("ERR::\(error)")
                break
            }
        }
    }
    
    func fetch(imageFor business: Business, atIndexPath indexPath: IndexPath, completion handler: @escaping (UIImage) -> Void) {
        
        if let businessId = business.id, let image = self.imageStore?.image(forKey: businessId) {
            handler(image)
            return
        }
        if let request = requests[indexPath] {
            request.priority = .high

            return
        }
        
        guard let imageURL = business.imageURL, let url = URL(string: imageURL) else { return }
        
        
        let request = self.fetcher.fetch(url, priority: .high) {
            result in
            
            let image: UIImage?
            switch result {
            case .success(let fetchedImage):
                image = fetchedImage
                
            case .failure(let error):
                let businessId = business.id ?? "<<unkown>>"
                
                switch error {
                case ImageFetcher.Error.canceled:
                    print("ERR::\(#function)::Cancelled fetching photo for business: \(businessId)")
                default:
                    print("ERR::\(#function)::Failed to fetch photo with id \(businessId): \(error)")
                }
                
                image = nil
            }
            
            guard let fetchedImage = image else { return }
            
            OperationQueue.main.addOperation {
                if let businessId = business.id {
                    self.imageStore?.setImage(fetchedImage, forKey: businessId)
                }
                
                handler(image!)
                
                self.requests[indexPath] = nil
            }
        }
        OperationQueue.main.addOperation {
            self.requests[indexPath] = request
        }
    }
    
    func fetch(for category: YelpCategory, completion hander: @escaping (Result<DecodeType, Error>) -> Void) {
        if !self.sectionData.contains(where: { $0.key == category.alias! }) {
            let latitude = UserDefaults.standard.double(forKey: "user.currentlocation.latitude")
            let longitude = UserDefaults.standard.double(forKey: "user.currentlocation.longitude")
            self.fetch(YelpRouter.getBusinessSearch(at: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), categories: [category.alias!]), completion: hander)
        }
    }
}

