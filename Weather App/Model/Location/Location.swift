//
//  Location.swift
//  Weather App
//
//  Created by Ahmad Jabri on 21/03/2020.
//  Copyright © 2020 Ahmad Jabri. All rights reserved.
//

import Foundation
import ObjectMapper

class Location: Object {
    var lon = 0.0
    var lat = 0.0
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        lon <- map["lon"]
        lat <- map["lat"]
    }
}
