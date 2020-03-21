//
//  WeatherObjectTest.swift
//  Weather AppTests
//
//  Created by Ahmad Jabri on 21/03/2020.
//  Copyright © 2020 Ahmad Jabri. All rights reserved.
//

import XCTest
@testable import Weather_App

class WeatherObjectTest: XCTestCase {
    
    let weatherObject = WeatherObject()
    
    func testWeather() {
        let weather = Weather()
        weather.description = "Sunny"
        weatherObject.weather = [weather]
        XCTAssertEqual(weatherObject.weather?.first?.description, "Sunny")
    }
    
    func testTemp() {
        let temp = Temp()
        temp.min = 9
        temp.max = 15
        weatherObject.temp = temp
        XCTAssertEqual(weatherObject.temp?.min, 9)
        XCTAssertEqual(weatherObject.temp?.max, 15)
    }
    
    func testWind() {
        let wind = Wind()
        wind.speed = 60
        weatherObject.wind = wind
        XCTAssertEqual(weatherObject.wind?.speed, 60)
    }
}
