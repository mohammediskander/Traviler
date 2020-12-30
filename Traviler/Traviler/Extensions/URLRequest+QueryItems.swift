//
//  URLRequest+QueryItems.swift
//  Flodel
//
//  Created by Mohammed Iskandar on 02/12/2020.
//

import Foundation

extension URLRequest {
    /// `URLQueryItem` array that attached to the `URLRequest`.
    var queryItems: [URLQueryItem]? {
        set {
            guard let queryItems = newValue else {
                return
            }
            
            self.url?.addQueryItems(queryItems)
        }
        
        get {
            return self.url?.getQueryItems()
        }
    }
}

typealias Parameters = [String: Any]

extension Parameters {
    /// Convert into `URLQueryItem` array
    /// - Returns: `Parameters` object converted into `URLQueryItem` array.
    func toURLQueryItems() -> [URLQueryItem] {
        var queryItems: [URLQueryItem] = []
        
        for param in self {
            queryItems.append(URLQueryItem(name: param.key, value: param.value as? String))
        }
        
        return queryItems
    }
    
    /// Add value into `Parameters` object. Inspired by `Swift.UserDefaults`
    /// - Parameters:
    ///   - value: Value to add
    ///   - forKey: Key of the value
    mutating func value(_ value: Any?, forKey: String) {
        if value != nil, let value = value {
            self[forKey] = "\(value)"
        }
    }
}
