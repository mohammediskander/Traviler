// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let yelpCategoryResponse = try? newJSONDecoder().decode(YelpCategoryResponse.self, from: jsonData)

import Foundation

// MARK: - YelpCategoryResponse
struct YelpCategoryResponse: Codable {
    let categories: [YelpCategory]?
}
