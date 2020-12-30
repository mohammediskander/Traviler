// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let condition = try? newJSONDecoder().decode(Condition.self, from: jsonData)

import Foundation

// MARK: - Condition
struct Condition: Codable {
    let text, icon: String?
    let code: Int?
}
