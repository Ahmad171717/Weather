//
//  Weather.swift
//  Weather App
//
//  Created by Ahmad Jabri on 21/03/2020.
//  Copyright © 2020 Ahmad Jabri. All rights reserved.
//

import ObjectMapper
import AlamofireObjectMapper
import PromiseKit
import Alamofire

class WeatherObject: Object {
    
    var location: Location?
    var temp: Temp?
    var weather: [Weather]?
    var wind: Wind?
    var cityName = ""
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        location        <- map["coord"]
        temp            <- map["main"]
        weather         <- map["weather"]
        wind            <- map["wind"]
        cityName        <- map["name"]
    }
}

extension WeatherObject {
    enum Router: Requestable {
        case listSelectedCitiesDetails(citiesId: [Int])
        case listCurrentCityDetails(cityname: String)
        
        var method: HTTPMethod { .get }
        
        var module: Module { .data }
        
        var path: ApiPath? { .version }
        
        var subPath: SubPath? {
            switch self {
            case .listSelectedCitiesDetails: return .group
            case .listCurrentCityDetails: return .forecast
            }
        }
        
        var parameters: Parameters? {
            switch self {
            case .listSelectedCitiesDetails(let citiesId): return ["units": "metric", "id": citiesId.map{"\($0)"}.joined(separator: ",")]
            case .listCurrentCityDetails(let cityName): return ["units": "metric", "q": cityName]
            }
        }
    }
}

extension WeatherObject {
    class WeatherObjectResponse: Object {

        var weatherObjects = [WeatherObject]()


        override func mapping(map: Map) {
            super.mapping(map: map)

            weatherObjects               <- map["list"]
        }
    }
}

extension WeatherObject {
    static func fetchSelectedCitiesWeatherObject(with citiesId: [Int]) -> Promise<[WeatherObject]> {
        return Promise { (resolver) in
            Router.listSelectedCitiesDetails(citiesId: citiesId).request { (response: DataResponse<WeatherObjectResponse>) in

                // reject if there is an error
                guard response.error == nil else {
                    if let error = response.error {
                    resolver.reject(error)
                    }
                    return
                }

                guard let response = response.value else { return }
                
                // fulfill weatherObjects
                resolver.fulfill(response.weatherObjects)
            }
        }
    }
}

extension WeatherObject {
    static func fetchCurrentCityWeatherObject(with cityName: String) -> Promise<[WeatherObject]> {
        return Promise { (resolver) in
            Router.listCurrentCityDetails(cityname: cityName).request { (response: DataResponse<WeatherObjectResponse>) in

                // reject if there is an error
                guard response.error == nil else {
                    if let error = response.error {
                    resolver.reject(error)
                    }
                    return
                }

                guard let response = response.value else { return }
                
                // fulfill weatherObjects
                resolver.fulfill(response.weatherObjects)
            }
        }
    }
}
