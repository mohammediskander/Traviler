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


/**
 {
     "id": "7O1ORGY36A-2aIENyaJWPg",
     "alias": "howlin-rays-los-angeles-3",
     "name": "Howlin' Ray's",
     "image_url": "https://s3-media2.fl.yelpcdn.com/bphoto/9hGoyECcrewigEKYEnrYTw/o.jpg",
     "is_closed": false,
     "url": "https://www.yelp.com/biz/howlin-rays-los-angeles-3?adjust_creative=rv1bDpOXYSa7ylsDbCPXYg&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_search&utm_source=rv1bDpOXYSa7ylsDbCPXYg",
     "review_count": 6586,
     "categories": [
         {
             "alias": "southern",
             "title": "Southern"
         },
         {
             "alias": "chickenshop",
             "title": "Chicken Shop"
         },
         {
             "alias": "tradamerican",
             "title": "American (Traditional)"
         }
     ],
     "rating": 4.5,
     "coordinates": {
         "latitude": 34.061517,
         "longitude": -118.239716
     },
     "transactions": [
         "delivery"
     ],
     "price": "$$",
     "location": {
         "address1": "727 N Broadway",
         "address2": "Ste 128",
         "address3": "",
         "city": "Los Angeles",
         "zip_code": "90012",
         "country": "US",
         "state": "CA",
         "display_address": [
             "727 N Broadway",
             "Ste 128",
             "Los Angeles, CA 90012"
         ]
     },
     "phone": "+12139358399",
     "display_phone": "(213) 935-8399",
     "distance": 34.48428972433532
 }
 */
