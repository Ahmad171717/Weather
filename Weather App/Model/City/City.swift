//
//  City.swift
//  Weather App
//
//  Created by Ahmad Jabri on 21/03/2020.
//  Copyright © 2020 Ahmad Jabri. All rights reserved.
//

import Foundation
import ObjectMapper
import PromiseKit

class City: Object {
    
    var name = ""
    var state = ""
    var country = ""
    var location: Location?
    private static var cache: [City]?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        name <- map["name"]
        state <- map["state"]
        country <- map["country"]
        location <- map["coord"]
    }
    
    static func city(with name: String) -> City? {
        var city: City?
        
        guard  City.cache == nil else {
            city = City.cache?.filter { $0.name == name }.first
            return city
        }
        
        fetchCities().done { cities in
            city = cities.filter { $0.name == name }.first
            }.catch { error in
                Alert.ok("Error", error.localizedDescription)
        }
        
        return city
    }
}

extension City: Listable {
    var listName: String {
        return name
    }
    
    func passesSearch(for key: String) -> Bool {
        let name = listName.localizedLowercase
        let searchKey = key.localizedLowercase
        
        return name.hasPrefix(searchKey)
    }
}

extension City {
    static func fetchCities() -> Promise<[City]> {
        return Promise { (resolver) in
            
            // return from cache if we have cached cities
            if let cities = City.cache {
                resolver.fulfill(cities)
                return
            }
            
            guard let url = URL(jsonPath: "City") else { return }
            do {
                let jsonData = try Data(contentsOf: url, options: [])
                guard let result = jsonData.jsonSerializd as? [[String: Any]] else { return }
                
                // mapping...
                let cities = Mapper<City>().mapArray(JSONArray: result)
                
                // save cities
                City.cache = cities
                
                // fulfill cities
                resolver.fulfill(cities)
                
            } catch let error {
                resolver.reject(error)
            }
        }
    }
}
