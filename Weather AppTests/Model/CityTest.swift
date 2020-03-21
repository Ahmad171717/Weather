//
//  City.swift
//  Weather AppTests
//
//  Created by Ahmad Jabri on 21/03/2020.
//  Copyright © 2020 Ahmad Jabri. All rights reserved.
//

import XCTest
@testable import Weather_App

class CityTest: XCTestCase {
    
    func testCity() {
        let city = City()
        
        city.id = 12
        XCTAssertEqual(city.id, 12)
        
        city.name = "Dubai"
        XCTAssertEqual(city.name, "Dubai")
        
        city.country = "AE"
        XCTAssertEqual(city.country, "AE")
    }
}
