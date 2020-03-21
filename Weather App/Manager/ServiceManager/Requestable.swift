//
//  Requestable.swift
//  Weather App
//
//  Created by Ahmad Jabri on 21/03/2020.
//  Copyright © 2020 Ahmad Jabri. All rights reserved.
//

import Alamofire
import ObjectMapper
import AlamofireObjectMapper

protocol Requestable: URLRequestConvertible {
    var method: HTTPMethod { get }
    var module: Module { get }
    var shouldAppendGuest: Bool { get }
    var path: ApiPath? { get }
    var subPath: SubPath? { get }
    var defaultParameters: Parameters? { get }
    var parameters: Parameters? { get }
    var downloadFileDestination: DownloadRequest.DownloadFileDestination? { get }
    var timeoutIntervalForRequest: TimeInterval { get }
    var moduleSpecificURL: URL? { get }
    var cachePolicy: URLRequest.CachePolicy { get }
    
    @discardableResult
    func request(with responseObject: @escaping (DefaultDataResponse) -> Void) -> DataRequest
    
    @discardableResult
    func request<T: BaseMappable>(with responseObject: @escaping (DataResponse<T>) -> Void) -> DataRequest
    
    @discardableResult
    func request<T: BaseMappable>(with responseArray: @escaping (DataResponse<[T]>) -> Void) -> DataRequest
    
    
    @discardableResult
    func request<T: BaseMappable>(with keyPath: String?, responseArray: @escaping (DataResponse<[T]>) -> Void) -> DataRequest
}

extension Requestable {
    // default caching policy for URL request
    var cachePolicy: URLRequest.CachePolicy {
        return URLRequest.CachePolicy.useProtocolCachePolicy
    }
    
    var shouldAppendGuest: Bool {
        return true
    }
    
    // default HTTP Method is get
    var method: HTTPMethod {
        return .get
    }
    
    // just to add nil as default path
    var path: ApiPath? {
        return nil
    }
    
    // just to add nil as default sub path
    var subPath: SubPath? {
        return nil
    }
    
    // just to add nil as default parameter
    var parameters: Parameters? {
        return nil
    }
    
    // default parameters
    var defaultParameters: Parameters? {
        ["appid": Configuration.current.environment.apiKey ?? ""]
    }
    
    // no default download file destination
    var downloadFileDestination: DownloadRequest.DownloadFileDestination? {
        return nil
    }
    
    // default timeoutIntervalForRequest
    var timeoutIntervalForRequest: TimeInterval {
        return 60.0
    }
    
    var moduleSpecificURL: URL? {
        return nil
    }
    
    @discardableResult
    func request(with responseObject: @escaping (DefaultDataResponse) -> Void) -> DataRequest {
        return ServiceManager.shared.request(self).response(completionHandler: responseObject).validateErrors()
    }
    
    @discardableResult
    func request<T: BaseMappable>(with responseObject: @escaping (DataResponse<T>) -> Void) -> DataRequest {
        return ServiceManager.shared.request(self).responseObject(completionHandler: responseObject).validateErrors()
    }
    
    @discardableResult
    func request<T: BaseMappable>(with responseArray: @escaping (DataResponse<[T]>) -> Void) -> DataRequest {
        return ServiceManager.shared.request(self).responseArray(completionHandler: responseArray).validateErrors()
    }
    
    @discardableResult
    func request<T: BaseMappable>(with keyPath: String?, mapToObject object: T?, with responseObject: @escaping (DataResponse<T>) -> Void) -> DataRequest {
        return ServiceManager.shared.request(self).responseObject(keyPath:keyPath, mapToObject: object, completionHandler: responseObject).validateErrors()
    }
    
    
    @discardableResult
    func request<T: BaseMappable>(with keyPath: String?, responseArray: @escaping (DataResponse<[T]>) -> Void) -> DataRequest {
        return ServiceManager.shared.request(self).responseArray(keyPath: keyPath, completionHandler: responseArray).validateErrors()
    }
    
    @discardableResult
    func request<T: BaseMappable>(with keyPath: String?, responseObject: @escaping (DataResponse<T>) -> Void) -> DataRequest {
        return ServiceManager.shared.request(self).responseObject(keyPath: keyPath, completionHandler: responseObject).validateErrors()
    }
    
    var url: URL {
        
        var apiUrl = ServiceManager.API.baseUrl
            
            
         apiUrl = apiUrl.appendingPathComponent(module.name)
        
        if let path = path, path.name.isNonEmpty {
            apiUrl = apiUrl.appendingPathComponent(path.name)
        }
         
        if let subPath = subPath, subPath.name.isNonEmpty {
            apiUrl = apiUrl.appendingPathComponent(subPath.name)
        }
        
        return apiUrl
    }
    
    func asURLRequest() throws -> URLRequest {
        
        // update timeoutIntervalForRequest from router
        ServiceManager.shared.manager.session.configuration.timeoutIntervalForRequest = timeoutIntervalForRequest
        
        var requestParams = parameters
        if let defaultParameters = defaultParameters {
            requestParams = defaultParameters.merging(parameters ?? [:]) { _, custom in custom }
        }
        
        
        var urlRequest = try URLRequest(url: moduleSpecificURL ?? url, method: method)
        urlRequest.cachePolicy = cachePolicy
        
         return try Alamofire.URLEncoding.default.encode(urlRequest, with: requestParams)
    }
}
