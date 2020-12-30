//
//  City.swift
//  Traviler
//
//  Created by Mohammed Iskandar on 22/12/2020.
//

import Foundation
import CoreLocation

struct City: Codable {
    let name: String!
    let country: String!
    lazy var coordinate: CLLocationCoordinate2D = .init(latitude: Double(self.latitude)!, longitude: Double(self.longitude)!)
    
    private let latitude: String!
    private let longitude: String!
    
    enum CodingKeys: String, CodingKey {
        case name
        case country
        
        case latitude = "lat"
        case longitude = "lng"
    }
}
