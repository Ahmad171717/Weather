//
//  Object.swift
//  Weather App
//
//  Created by Ahmad Jabri on 21/03/2020.
//  Copyright © 2020 Ahmad Jabri. All rights reserved.
//

import ObjectMapper

class Object: MappableObject {
    
    // id for equatable
    var id = 0
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        id  <- map["id"]
    }
    
    /// Override in subclasses if needed
    func isEqual(to: Object) -> Bool {
        return id == to.id
    }
}

extension Object: Equatable {
    static func == (lhs: Object, rhs: Object) -> Bool {
        return lhs.isEqual(to: rhs)
    }
}
