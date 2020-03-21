//
//  ServiceManager.swift
//  Weather App
//
//  Created by Ahmad Jabri on 21/03/2020.
//  Copyright © 2020 Ahmad Jabri. All rights reserved.
//

import Alamofire

class ServiceManager {
 
    static let shared = ServiceManager()

    var manager: Alamofire.SessionManager
    

    private init() {
        
        // manager
        manager = Alamofire.SessionManager(configuration: URLSessionConfiguration.default)
    }

    func request(_ urlRequest: URLRequestConvertible) -> DataRequest {
        return manager.request(urlRequest)
    }
}

extension ServiceManager {
    struct API {
        static var baseUrl: URL {
            
            let url = Configuration.current.baseUrl ?? URL(fileURLWithPath: Configuration.current.baseUrl?.absoluteString ?? "")
            
            return url
        }
    }
}
