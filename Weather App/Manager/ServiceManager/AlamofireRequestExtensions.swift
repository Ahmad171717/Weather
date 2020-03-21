//
//  AlamofireRequestExtensions.swift
//  Weather App
//
//  Created by Ahmad Jabri on 21/03/2020.
//  Copyright © 2020 Ahmad Jabri. All rights reserved.
//

import Alamofire
import ObjectMapper

public extension Alamofire.Request {
    
    /// Prints the log for the request
    @discardableResult
    func debug() -> Self {
        print(debugDescription)
        return self
    }
}

public extension Alamofire.DataRequest {
    
    @discardableResult
    func validateErrors() -> Self {
        return validate { [weak self] (request, response, data) -> Alamofire.Request.ValidationResult in
            
            // get status code from server
            let code = response.statusCode
            
            // check the request url
            let requestURL = String(describing: request?.url?.absoluteString ?? "NO URL")
            
            var result: Alamofire.Request.ValidationResult = .success
            
            guard let data = data else {
                // create error
                
                let iSteelError = WeatherError(code: code, domain: "Error", message: "system unavailable")
                result =  .failure(iSteelError)
                return result
            }
                
            // check if response is empty
            guard let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: Any]  else {
                self?.log(code: code, url: requestURL, message: "Empty response" as AnyObject, isError: false, request: request)
                if code == 200 {
                    return result
                } else {
                    let iSteelError = WeatherError(code: code, domain: "empty", message: "system unavailable")
                    result = .failure(iSteelError)
                    return result
                }
            }
                
            // check response contains error
            if let errors = json["errors"] as? [[String: Any]], let firstError = errors.first {
                
                // create error
                let ardhiError = WeatherError(JSON: firstError) ?? WeatherError()
                
                self?.log(code: code, url: requestURL, message: json as AnyObject, isError: true, request: request)
                result = .failure(ardhiError)
                
            } else {
                self?.log(code: code, url: requestURL, message: json as AnyObject, isError: false, request: request)
                result = .success
            }
            
            return result
            }
            // validate for request errors
            .validate()
            
            // log request
            .debug()
    }
    
    private func log(code: Int, url: String, message: AnyObject, isError: Bool, request: URLRequest?) {
        
        if isError {
            print("FAILED")
        }
        
        print("Status Code >> \(code)")
        print("URL >> \(url)")
        print("Request >> \(request?.allHTTPHeaderFields ?? [:])")
        print("Response >> \(message)")
    }
}
