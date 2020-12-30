//
//  CustomAPI.swift
//  Traviler
//
//  Created by Mohammed Iskandar on 24/12/2020.
//

import Foundation

enum CountriesAPI: Router {
    
    static var baseURL: URL? = URL(string: "https://safcsp-country.herokuapp.com/services/countries")
    
    case getAllCountries(limit: Int? = 10, page: Int? = 1)
    case getCitiesIn(country: String)
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        switch self {
        case .getAllCountries:
            return "/"
        case .getCitiesIn(country: let code):
            return String(format: "/cities/%@", code)
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .getAllCountries(limit: let limit, page: let page):
            return [
                "limit": String(limit!),
                "page": String(page!)
            ]
        default:
            return nil
        }
    }
    
    var accessType: AccessType? {
        return .publicRoute
    }
    
    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: CountriesAPI.baseURL!.appendingPathComponent(path))
        
        urlRequest.httpMethod = method.rawValue
        
        urlRequest.addValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.addValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        if let parameters = parameters {
            do {
                if method == .get {
                    urlRequest.queryItems = parameters.toURLQueryItems()
                } else {
                    urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
                }
            } catch {
                throw ParametersError.encodingError
            }
        }
        
        return urlRequest;
    }
}
