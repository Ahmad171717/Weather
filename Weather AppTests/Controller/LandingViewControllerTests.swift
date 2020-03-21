//
//  LandingViewControllerTests.swift
//  Weather AppTests
//
//  Created by Ahmad Jabri on 21/03/2020.
//  Copyright © 2020 Ahmad Jabri. All rights reserved.
//

import XCTest
@testable import Weather_App

class LandingViewControllerTest: XCTestCase {
    var landingViewController: LandingViewController?
    
    override func setUp() {
        super.setUp()
        
        landingViewController = LandingViewController.instantiate()
        _ = landingViewController?.view
    }
    
    override func tearDown() {
        super.tearDown()
        
        landingViewController = nil
    }
    
    func testCanLoadView() {
        XCTAssertNotNil(landingViewController, "view can load without crash")
    }
    
    func testViewHasTwoButtons() {
        XCTAssertNotNil(landingViewController?.buttonMultiCity, "button multi city is there")
        XCTAssertNotNil(landingViewController?.buttonCurrentCity, "button current city is there")
    }
    
    func testCurrentCityDetailsRequest() {
        WeatherObject.Router.listCurrentCityDetails(cityname: "Dubai").request { _ in }
    }
    
    func testMultiCityDetailsRequest() {
        
        let firstCityId = 524901
        let secondCityID = 703448
        let thirdCityId = 2643743
        let citiesId = [firstCityId, secondCityID, thirdCityId]
        
        XCTAssertGreaterThan(citiesId.count, 2)
        XCTAssertLessThan(citiesId.count, 8)
        
        WeatherObject.Router.listSelectedCitiesDetails(citiesId: citiesId).request { _ in }
    }
}
