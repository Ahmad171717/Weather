//
//  WeatherError.swift
//  Weather App
//
//  Created by Ahmad Jabri on 21/03/2020.
//  Copyright © 2020 Ahmad Jabri. All rights reserved.
//

import Foundation
import ObjectMapper

class WeatherError: Object, Error {
    
    var code = 0
    var errorCode = ""
    var domain = ""
    var message = ""

    override func mapping(map: Map) {
        super.mapping(map: map)
        
        code     <- map["code"]
        message  <- map["message"]
        errorCode <- map["code"]
    }
    
    convenience init(code: Int, errorCode: String = "", domain: String = "", message: String = "") {
        self.init()
        self.code = code
        self.errorCode = errorCode
        self.domain = domain
        self.message = message
    }
    
    convenience init(error: Error, message: String? = "") {
        self.init(code: error.code, domain: error.domain, message: message ?? "Unknown Erro")
    }
}

extension Error {
    
    var code: Int {
        return (self as? WeatherError)?.code ?? 0
    }
    
    var errorCode: String {
        return (self as? WeatherError)?.errorCode ?? ""
    }
    
    var domain: String {
        return (self as? WeatherError)?.domain ?? ""
    }
    
    var message: String {
        return (self as? WeatherError)?.message ?? ""
    }
    
    var localizedDescription: String {
        
        // customize request timed out error message
        guard (self as NSError).code != NSURLErrorTimedOut else {
            return "system unavailable"
        }
        
        if let ardhiError = self as? WeatherError {
            
            // show Ardhi error message if self is ArdhiError
            return ardhiError.message
        } else {
            
            // else show localizedDescription of NSError
            return (self as NSError).localizedDescription
        }
    }
}
