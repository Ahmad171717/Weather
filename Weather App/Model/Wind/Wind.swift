//
//  Wind.swift
//  Weather App
//
//  Created by Ahmad Jabri on 21/03/2020.
//  Copyright © 2020 Ahmad Jabri. All rights reserved.
//

import Foundation
import ObjectMapper

class Wind: Object {
    
    var speed = 0
    var deg = 0
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        speed <- map["speed"]
        deg <- map["deg"]
    }
}
