//
//  LandingViewController.swift
//  Weather App
//
//  Created by Ahmad Jabri on 20/03/2020.
//  Copyright © 2020 Ahmad Jabri. All rights reserved.
//

import UIKit
import CoreLocation

class LandingViewController: BaseViewController {
    
    override var shouldHideNavigationBar: Bool { true }
    
    @IBOutlet private (set) weak var buttonMultiCity: UIButton?
    @IBOutlet private (set) weak var buttonCurrentCity: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonMultiCity?.setTitle("Multi City", for: .normal)
        buttonCurrentCity?.setTitle("Current City", for: .normal)
    }
    
    @IBAction func buttonActionMultiCity(_ sender: UIButton) {
        LoadingIndicator.shared.show()
        
        // add small delay because it's a big data to load
        delay(100) { [weak self] in
            self?.fetchCities()
        }
    }
    
    @IBAction func buttonActionCurrentCity(_ sender: UIButton) {
        
        
        switch LocationManager.shared.locationStatus {
        case .denied:
            // show alert
            Alert.ok("Location Error", "Please enable location from settings")
        case .notDetermined:

            // request for location
            // then after small delay fetch the location
            LocationManager.shared.requestWhenInUseAuthorization { [weak self] _ in
                delay(1500) {
                    self?.fetchCurrentLocation()
                }
            }
        default: fetchCurrentLocation()
        }
    }
}

extension LandingViewController {
    func fetchCities() {
        LoadingIndicator.shared.show()
        
        // fetch list cities
        City.fetchCities().done { cities in
            
            // list all the cities
            ListingViewController.present { controller in
                controller.list = cities
                controller.listSelectionHandler = { [weak self] cities in
                    
                    // handle selected selected cities action
                    self?.fetchCitiesWeather(cities: cities)
                }
            }
        }.catch { error in
            Alert.ok("Error", error.localizedDescription)
        }.finally {
            LoadingIndicator.shared.dismiss()
        }
    }
    
    func fetchCitiesWeather(cities: [Listable]?) {
        LoadingIndicator.shared.show()
        guard let cities = cities as? [City], cities.count > 2, cities.count < 8 else { return }
        
        // get selected city id
        let citiesId = cities.map { $0.id }
        
        
        // fetch weather objects
        WeatherObject.fetchSelectedCitiesWeatherObject(with: citiesId).done { weatherObjects in
            var list = [WeatherPresentable]()
            
            // add weather details to the list
            weatherObjects.forEach { object in
                let item = MultiCityWeather(title: object.cityName, weatherObject: object)
                list.append(item)
            }
            
            // show multi city list details
            MultiCityViewController.push { controller in
                controller.list = list
            }
            
        }.catch { error in
            Alert.ok("Error", error.localizedDescription)
        }.finally {
            LoadingIndicator.shared.dismiss()
        }
    }
    
    func fetchCurrentLocation() {
        LocationManager.shared.fetchCurrentLocation { [weak self] (location, error) in
            guard error == nil else {
                Alert.ok("Error", error?.localizedDescription)
                return
            }
            
            guard let location = location else { return }
            self?.getCurrentCity(from: location)
        }
    }
    
    func getCurrentCity(from location: CLLocation) {
        LocationManager.shared.lookUp(currentLocation: location) { [weak self] placeMark in
            guard let cityName = placeMark?.administrativeArea else { return }
            self?.getCurrentCityWeatherObject(currentCityName: cityName)
        }
    }
    
    func getCurrentCityWeatherObject(currentCityName: String) {
        LoadingIndicator.shared.show()
        WeatherObject.fetchCurrentCityWeatherObject(with: currentCityName).done { weatherObjects in
            var list = [WeatherPresentable]()
            
            // add weather details to the list
            weatherObjects.forEach { object in
                let item = MultiCityWeather(title: nil, weatherObject: object)
                list.append(item)
            }
            
            // show multi city list details
            CurrentCityViewController.push { controller in
                controller.list = list
            }
            
        }.catch { error in
            Alert.ok("Error", error.localizedDescription)
        }.finally {
            LoadingIndicator.shared.dismiss()
        }
    }
}

extension LandingViewController {
    
    // multi city presentable object
    struct MultiCityWeather: WeatherPresentable {
        var title: String?
        var weatherObject: WeatherObject
    }
    
    // current city presentable object
    struct CurrentCityWeather: WeatherPresentable {
        var title: String?
        var weatherObject: WeatherObject
    }
}


