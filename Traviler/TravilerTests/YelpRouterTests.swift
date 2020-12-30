//
//  YelpTests.swift
//  TravilerTests
//
//  Created by Mohammed Iskandar on 30/12/2020.
//

import XCTest
import CoreLocation
@testable import Traviler

class YelpRouterTest: XCTestCase {
    func testsThatGetBusinessSearchAsURLRequestsReturnValidURL() {
        let inputURLRequest = try? YelpRouter.getBusinessSearch(at: CLLocationCoordinate2D(latitude: 10.0, longitude: 10.0), term: "food", limit: 40, offset: 20, openNow: true).asURLRequest()
        
        let expectedQueryItemsOutput = YelpConstants.getBusinessSearchRequiredParameters.toURLQueryItems()
        for expectedQueryItemOutput in expectedQueryItemsOutput {
            XCTAssertTrue(inputURLRequest!.queryItems!.contains(expectedQueryItemOutput))
        }
        XCTAssertEqual(inputURLRequest!.queryItems!.count, YelpConstants.getBusinessSearchRequiredParameters.count)
        
        XCTAssertEqual(inputURLRequest?.allHTTPHeaderFields!["Authorization"], YelpConstants.apiKey)
        
        let expectedMethodOutput = YelpConstants.yelpHttpMethod.rawValue
        XCTAssertEqual(inputURLRequest?.httpMethod, expectedMethodOutput)
        
        
        let inputURL = inputURLRequest?.url?.relativePath
        let expectedURLOutput = YelpConstants.baseURL.appendingPathComponent(YelpConstants.getBusinessSearchPath).relativePath
        
        XCTAssertEqual(inputURL, expectedURLOutput)
        
    }
    
    func testsThatGetBusinessDetailsAsURLRequestsReturnValidURL() {
        let inputURLRequest = try? YelpRouter.getBusinessDetails(forBusinessWithId: YelpConstants.id).asURLRequest()

        let expectedQueryItemsOutput = YelpConstants.getBusinessDetailsRequiredParameters.toURLQueryItems()
        for expectedQueryItemOutput in expectedQueryItemsOutput {
            XCTAssertTrue(inputURLRequest!.queryItems!.contains(expectedQueryItemOutput))
        }
        
        XCTAssertEqual(inputURLRequest!.queryItems!.count, YelpConstants.getBusinessDetailsRequiredParameters.count)

        XCTAssertEqual(inputURLRequest?.allHTTPHeaderFields!["Authorization"], YelpConstants.apiKey)
        
        let expectedMethodOutput = YelpConstants.yelpHttpMethod.rawValue
        XCTAssertEqual(inputURLRequest?.httpMethod, expectedMethodOutput)

        let inputURL = inputURLRequest?.url?.relativePath
        let expectedURLOutput = YelpConstants.baseURL.appendingPathComponent(YelpConstants.getBusinessDetailsPath).relativePath

        XCTAssertEqual(inputURL, expectedURLOutput)
    }
    
    func testsThatGetCategoriesAsURLRequestsReturnValidURL() {
        let inputURLRequest = try? YelpRouter.getAllCategories.asURLRequest()

        let expectedQueryItemsOutput = YelpConstants.getCategoriesRequiredParameters.toURLQueryItems()
        for expectedQueryItemOutput in expectedQueryItemsOutput {
            XCTAssertTrue(inputURLRequest!.queryItems!.contains(expectedQueryItemOutput))
        }
        
        XCTAssertEqual(inputURLRequest!.queryItems!.count, YelpConstants.getCategoriesRequiredParameters.count)

        XCTAssertEqual(inputURLRequest?.allHTTPHeaderFields!["Authorization"], YelpConstants.apiKey)
        
        let expectedMethodOutput = YelpConstants.yelpHttpMethod.rawValue
        XCTAssertEqual(inputURLRequest?.httpMethod, expectedMethodOutput)

        let inputURL = inputURLRequest?.url?.relativePath
        let expectedURLOutput = YelpConstants.baseURL.appendingPathComponent(YelpConstants.getCategoriesPath).relativePath

        XCTAssertEqual(inputURL, expectedURLOutput)
    }
}
