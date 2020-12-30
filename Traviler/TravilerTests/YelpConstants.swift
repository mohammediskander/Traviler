//
//  YelpConstants.swift
//  TravilerTests
//
//  Created by Mohammed Iskandar on 30/12/2020.
//

import Foundation
@testable import Traviler

class YelpConstants {
    static var apiKey: String = "Bearer NqVUQnskfp-PPWlMJ1brhyW5iDI-Ymn6GjT07Yi3psvIfQFWbndi4C7uMc0ZmokkqbnsfokUSTbqbsnkEUl4GYsOAzQkGnAgJNNaFkGRX0l__AuQV2cb0MZb26LsX3Yx"
    static var baseURL: URL = URL(string: "https://api.yelp.com/v3")!
    
    static var id = "7O1ORGY36A-2aIENyaJWPg"
    
    static var getBusinessSearchPath = "/businesses/search"
    static var getBusinessDetailsPath = String(format: "/businesses/", YelpConstants.id)
    static var getCategoriesPath = "/categories"
    
    static var getBusinessSearchRequiredParameters: Parameters = [
        "latitude": "10.0",
        "longitude": "10.0",
        "term": "food",
        "radius": "4000",
        "limit": "40",
        "offset": "20",
        "open_now": "true"
    ]
    static var getBusinessDetailsRequiredParameters: Parameters = [:]
    static var getCategoriesRequiredParameters: Parameters = [:]
    
    static let yelpHttpMethod = HTTPMethod.get
}
