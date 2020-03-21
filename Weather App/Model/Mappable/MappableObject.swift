//
//  MappableObject.swift
//  Weather App
//
//  Created by Ahmad Jabri on 21/03/2020.
//  Copyright © 2020 Ahmad Jabri. All rights reserved.
//

import ObjectMapper

class MappableObject: Mappable {
    
    required init?(map: Map) {
        // to confirm protocol
    }
    
    func mapping(map: Map) {
        // to be override
    }
    
    init() {
         // to create object without a JSON
    }
}
