//
//  Configuration.swift
//  Weather App
//
//  Created by Ahmad Jabri on 21/03/2020.
//  Copyright © 2020 Ahmad Jabri. All rights reserved.
//

import Foundation
import ObjectMapper

class Configuration {
    typealias JSON = [String: Any]
    
    static let current = Configuration()
    
    var all = JSON()
    
    var environment: Environment {
        guard let environment = Environment(JSON: Environment.attributes) else {
            fatalError("XXX 😂😜 ADD Environment TO YOUR CONFIGURATION FILE!!!")
        }
        
        return environment
    }
    
    private init() {
        
        // load all configurations one time
        all = Bundle.main.infoDictionary?["Configuration"] as? JSON ?? [:]
    }
}

extension Configuration {
    
    var baseUrl: URL? {
        return createBaseUrl()
    }
}

private extension Configuration {
    func createBaseUrl() -> URL? {
        guard let host = Configuration.current.environment.host, let `protocol` = Configuration.current.environment.`protocol` else {
            fatalError("XXX 😂😜 ADD HOST AND PROTOCOL TO YOUR CONFIGURATION FILE!!!")
        }
                
        return URL(string: `protocol` + "://" + host)
    }
}

extension Configuration {
    
    class Environment: Object {
        
        // URL's protocol (http/https)
        var `protocol`: String?
        
        // host address
        var host: String?
        
        // current scheme
        var scheme: Scheme?
        
        // apiKey
        var apiKey: String?
                
        
        // Json Attributes of environment key
        static var attributes: JSON {
            return Configuration.current.all["Environment"] as? JSON ?? [:]
        }
        
        // Mapping model properties
        override func mapping(map: Map) {
            `protocol`         <- map["Protocol"]
            host               <- map["Host"]
            scheme             <- map["Scheme"]
            apiKey             <- map["APIKey"]
        }
    }
}

extension Configuration {
    enum Scheme: String {
        case release = "Release"
    }
}
