//
//  Temp.swift
//  Weather App
//
//  Created by Ahmad Jabri on 21/03/2020.
//  Copyright © 2020 Ahmad Jabri. All rights reserved.
//

import Foundation
import ObjectMapper

class Temp: Object {
    
    var min = 0
    var max = 0
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        min <- map["temp_min"]
        max <- map["temp_max"]
    }
}
