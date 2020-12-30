//
//  WeatherRouterTests.swift
//  TravilerTests
//
//  Created by Mohammed Iskandar on 30/12/2020.
//

import XCTest
import CoreLocation
@testable import Traviler

class WeatherRouterTest: XCTestCase {
    func testsThatGetCurrentWeatherAsURLRequestsReturnValidURL() {
        let inputURLRequest = try? WeatherRouter.getCurrentWeather(at: CLLocationCoordinate2D(latitude: 10.0, longitude: 10.0)).asURLRequest()
        
        let expectedQueryItemsOutput = WeatherConstants.getCurrentRequiredMethod.toURLQueryItems()
        for expectedQueryItemOutput in expectedQueryItemsOutput {
            XCTAssertTrue(inputURLRequest!.queryItems!.contains(expectedQueryItemOutput))
        }
        
        let expectedMethodOutput = WeatherConstants.weahterHttpMethod.rawValue
        XCTAssertEqual(inputURLRequest?.httpMethod, expectedMethodOutput)
        
        
        let inputURL = inputURLRequest?.url?.relativePath
        let expectedURLOutput = WeatherConstants.baseURL.appendingPathComponent(WeatherConstants.getCurrentPath).relativePath
        
        XCTAssertEqual(inputURL, expectedURLOutput)
        
    }
    
    func testsThatGetForecastWeatherAsURLRequestsReturnValidURL() {
        let inputURLRequest = try? WeatherRouter.getForecast(days: 1, at: CLLocationCoordinate2D(latitude: 10.0, longitude: 10.0)).asURLRequest()
        
        let expectedQueryItemsOutput = WeatherConstants.getForecastRequiredMethod.toURLQueryItems()
        for expectedQueryItemOutput in expectedQueryItemsOutput {
            XCTAssertTrue(inputURLRequest!.queryItems!.contains(expectedQueryItemOutput))
        }
        
        let expectedMethodOutput = WeatherConstants.weahterHttpMethod.rawValue
        XCTAssertEqual(inputURLRequest?.httpMethod, expectedMethodOutput)
        
        let inputURL = inputURLRequest?.url?.relativePath
        let expectedURLOutput = WeatherConstants.baseURL.appendingPathComponent(WeatherConstants.getForecastPath).relativePath
        
        XCTAssertEqual(inputURL, expectedURLOutput)
    }
}
