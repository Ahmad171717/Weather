//
//  Weather.swift
//  Weather App
//
//  Created by Ahmad Jabri on 21/03/2020.
//  Copyright © 2020 Ahmad Jabri. All rights reserved.
//

import Foundation
import ObjectMapper

class Weather: Object {
    
    var description = ""
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        description <- map["description"]
    }
}
