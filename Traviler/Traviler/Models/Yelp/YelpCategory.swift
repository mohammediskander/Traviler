// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let category = try? newJSONDecoder().decode(Category.self, from: jsonData)

import Foundation

// MARK: - Category
struct YelpCategory: Codable, Equatable {
    
    static func == (lhs: YelpCategory, rhs: YelpCategory) -> Bool {
        return lhs.alias == rhs.alias
    }
    
    let alias, title: String?
    let parentAliases: [JSONAny]?
    let countryWhitelist: [String]?
    let countryBlacklist: [JSONAny]?

    enum CodingKeys: String, CodingKey {
        case alias, title
        case parentAliases = "parent_aliases"
        case countryWhitelist = "country_whitelist"
        case countryBlacklist = "country_blacklist"
    }
}
