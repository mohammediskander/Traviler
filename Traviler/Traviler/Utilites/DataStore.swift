//
//  DataSource.swift
//  Traviler
//
//  Created by Mohammed Iskandar on 25/12/2020.
//

import Foundation


protocol DataSourceDelegate: AnyObject {
    func handleDataSource<T>(_ data: [T], didUpdatFrom oldValue: [T]?)
}


protocol DataSource: AnyObject {
    associatedtype DataType: Codable & Equatable
    associatedtype DecodeType: Codable

    associatedtype ResultType = Swift.Result<Self.DataType, Error>
    associatedtype ResultHandlerType = (Self.ResultType) -> Void
    associatedtype T = Self where T: NSObject
    
    var delegate: DataSourceDelegate? { get set }
    static var shared: T? { get set }
    
    var imageStore: ImageStore? { get set}

    var data: [DataType] { get set }
}

extension DataSource {
    
    static var session: URLSession {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }
    
    static var documentDirectoryURL: URL? {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        guard let documentDirectory = documentsDirectories.first else { return nil }
        
        return documentDirectory
    }
    
    func dataSource(_ data: [Self.DataType], didUpdateFrom oldValue: [Self.DataType]?) {
        self.delegate?.handleDataSource(self.data, didUpdatFrom: oldValue)
    }
    
    func fetch(_ endpoint: Router, updating: [DataType]? = nil, completion handler: @escaping (Result<DecodeType, Swift.Error>) -> Void) {
        Self.session.fetch(endpoint, decode: DecodeType.self, completion: handler)
    }
}
