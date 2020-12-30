// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let yelpSearchResponse = try? newJSONDecoder().decode(YelpSearchResponse.self, from: jsonData)

import Foundation

// MARK: - YelpSearchResponse
struct YelpSearchResponse: Codable {
    let total: Int?
    let businesses: [Business]?
    let region: Region?
}
