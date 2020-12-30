//
//  WeatherAPI.swift
//  Traviler
//
//  Created by Mohammed Iskandar on 27/12/2020.
//

import Foundation
import CoreLocation

enum WeatherRouter: Router {
    
    private static var apiKey: String = "334ab64bc83c4de4ae5143456202712"
    static var baseURL: URL? = URL(string: "https://api.weatherapi.com/v1")
    
    case getCurrentWeather(at: CLLocationCoordinate2D)
    case getForecast(days: Int, at: CLLocationCoordinate2D)
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        switch self {
        case .getCurrentWeather:
            return "/current.json"
            
        case .getForecast:
            return "/forecast.json"
            
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .getCurrentWeather(at: let coordinate):
            var parameters: Parameters = [:]
            
            parameters.value("\(coordinate.latitude),\(coordinate.longitude)", forKey: "q")
            
            return parameters
            
        case .getForecast(days: let days, at: let coordinate):
            var parameters: Parameters = [:]
            
            parameters.value(days, forKey: "days")
            parameters.value("\(coordinate.latitude),\(coordinate.longitude)", forKey: "q")
            
            return parameters
        }
    }
    
    var accessType: AccessType? {
        return .publicRoute
    }
    
    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: WeatherRouter.baseURL!.appendingPathComponent(path))
        
        urlRequest.httpMethod = method.rawValue
        
        urlRequest.addValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.addValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
//        if var parameters = parameters {
//            parameters.value(WeatherAPI.apiKey, forKey: "key")
//        }
        
        do {
            if method == .get {
                urlRequest.queryItems = parameters!.toURLQueryItems()
            } else {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters!, options: [])
            }
        } catch {
            throw ParametersError.encodingError
        }
        
        urlRequest.queryItems?.append(URLQueryItem(name: "key", value: WeatherRouter.apiKey))
        
        return urlRequest;
    }
}
