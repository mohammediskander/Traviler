// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let business = try? newJSONDecoder().decode(Business.self, from: jsonData)

import Foundation

// MARK: - Business
struct Business: Codable, Equatable {
    
    static func == (lhs: Business, rhs: Business) -> Bool {
        return lhs.id == rhs.id && lhs.weather == rhs.weather
    }
    
    let rating: Double?
    let price, phone, id, alias: String?
    let isClosed: Bool?
    let categories: [YelpCategory]?
    let reviewCount: Int?
    let name: String?
    let url: String?
    let coordinates: Center?
    let imageURL: String?
    let location: YelpLocation?
    let distance: Double?
    let transactions: [String]?
    
    // Weather
    var weather: Current?

    enum CodingKeys: String, CodingKey {
        case rating, price, phone, id, alias
        case isClosed = "is_closed"
        case categories
        case reviewCount = "review_count"
        case name, url, coordinates
        case imageURL = "image_url"
        case location, distance, transactions
    }
}
