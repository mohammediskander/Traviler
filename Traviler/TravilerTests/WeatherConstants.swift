//
//  WeatherConstants.swift
//  TravilerTests
//
//  Created by Mohammed Iskandar on 30/12/2020.
//

import Foundation
@testable import Traviler

class WeatherConstants {
    static let getCurrentRequiredMethod: Parameters = [
        "q": "10.0,10.0",
        "key": "334ab64bc83c4de4ae5143456202712",
    ]
    static let baseURL: URL = URL(string: "https://api.weatherapi.com/v1")!
    static let getCurrentPath = "/current.json"
    static let getForecastPath = "/forecast.json"
    
    static let getForecastRequiredMethod: Parameters = [
        "q": "10.0,10.0",
        "key": "334ab64bc83c4de4ae5143456202712",
        "days": "1"
    ]
    
    static let weahterHttpMethod = HTTPMethod.get
}
