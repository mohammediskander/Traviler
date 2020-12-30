//
//  YelpRouter.swift
//  Traviler
//
//  Created by Mohammed Iskandar on 26/12/2020.
//

import Foundation
import CoreLocation

// LA: 34.05223, -118.24368

enum YelpSearchAttribute: String {
    case hotAndNew = "hot_and_new"
    case requestAQuote = "request_a_quote"
    case reservation
    case waitlistReservation = "waitlist_reservation"
    case daels
    case genderNeutralRestrooms = "gender_neutral_restrooms"
    case openToAll = "open_to_all"
    case wheelchairAccessible = "wheelchair_accessible"
}

extension Array where Element == YelpSearchAttribute {
    func joined(seperator: String) -> String {
        
        var arrayOfStrings: [String] = []
        
        for element in self {
            arrayOfStrings.append(element.rawValue)
        }
        
        return arrayOfStrings.joined(separator: seperator)
    }
}

enum YelpRouter: Router {
    
    private static var clientId: String = "1P9DI8fenfBmyEcFnQyR6w"
    private static var apiKey: String = "NqVUQnskfp-PPWlMJ1brhyW5iDI-Ymn6GjT07Yi3psvIfQFWbndi4C7uMc0ZmokkqbnsfokUSTbqbsnkEUl4GYsOAzQkGnAgJNNaFkGRX0l__AuQV2cb0MZb26LsX3Yx"
    
    case getBusinessSearch(
            at: CLLocationCoordinate2D,
            term: String? = nil,
            radius: Int? = 4000,
            categories: [String]? = nil,
            limit: Int? = 20,
            offset: Int? = 0,
            sortBy: String? = nil,
            price: [Int]? = nil,
            openNow: Bool? = nil,
            attributes: [YelpSearchAttribute]? = nil
         ) // https://www.yelp.com/developers/documentation/v3/business_search
    case getBusinessDetails(forBusinessWithId: String) // https://www.yelp.com/developers/documentation/v3/business
    case getAllCategories // https://www.yelp.com/developers/documentation/v3/all_categories
    
    
    static var baseURL: URL? = URL(string: "https://api.yelp.com/v3")!
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        switch self {
        case .getBusinessSearch:
            return "/businesses/search"
            
        case .getBusinessDetails(forBusinessWithId: let id):
            return String(format: "/businesses/", id)
            
        case .getAllCategories:
            return "/categories"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .getBusinessSearch(at: let coordinate, term: let term, radius: let radius, categories: let categories, limit: let limit, offset: let offset, sortBy: let sortBy, price: let price, openNow: let openNow, attributes: let attributes):
            var parameters: Parameters = [:]
            
            parameters.value(term, forKey: "term")
            parameters.value(coordinate.latitude, forKey: "latitude")
            parameters.value(coordinate.longitude, forKey: "longitude")
            parameters.value(radius, forKey: "radius")
            parameters.value(categories?.joined(separator: ","), forKey: "categories")
            parameters.value(limit, forKey: "limit")
            parameters.value(offset, forKey: "offset")
            parameters.value(sortBy, forKey: "sort_by")
            parameters.value(price?.strinifyJoined(seperator: ","), forKey: "price")
            parameters.value(openNow, forKey: "open_now")
            parameters.value(attributes?.joined(seperator: ","), forKey: "attributes")
            
            return parameters
        default:
            return [:]
        }
    }
    
    var accessType: AccessType? {
        return .privateRoute
    }
    
    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: YelpRouter.baseURL!.appendingPathComponent(path))
        
        urlRequest.httpMethod = method.rawValue
        
        urlRequest.addValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.addValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        
        if let accessType = self.accessType, accessType == .privateRoute {
            urlRequest.addValue("Bearer \(YelpRouter.apiKey)", forHTTPHeaderField: HTTPHeaderField.authorization.rawValue)
        }
        
        do {
            if method == .get {
                urlRequest.queryItems = parameters!.toURLQueryItems()
            } else {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters!, options: [])
            }
        } catch {
            throw ParametersError.encodingError
        }
        
        return urlRequest;
    }
}
