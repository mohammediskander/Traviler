//
//  URL+URLComponents.swift
//  Traviler
//
//  Created by Mohammed Iskandar on 02/12/2020.
//

import Foundation

extension URL {
    /// Convert into `URLComponents`
    /// - Returns: The `URL` converted into `URLComponents?`
    func toURLComponents() -> URLComponents? {
        return URLComponents(url: self, resolvingAgainstBaseURL: false)
    }
    
    /// Add an array of `URLQueryItem` to the url
    /// - Parameter queryItems: `URLQueryItem` array to add
    mutating func addQueryItems(_ queryItems: [URLQueryItem]) {
        
        var urlComponent = self.toURLComponents()
        urlComponent?.queryItems = queryItems
        
        self = (urlComponent?.url)!
    }
    
    /// Get the quety items
    /// - Returns: The `URLQueryItem` array attached to the `URL`
    func getQueryItems() -> [URLQueryItem]? {
        return self.toURLComponents()?.queryItems
    }
}
