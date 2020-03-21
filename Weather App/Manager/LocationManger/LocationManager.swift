//
//  LocationManager.swift
//  Weather App
//
//  Created by Ahmad Jabri on 21/03/2020.
//  Copyright © 2020 Ahmad Jabri. All rights reserved.
//

import UIKit
import CoreLocation

class LocationManager: NSObject {
    
    
    static var shared = LocationManager()
    fileprivate var manager = CLLocationManager()
    fileprivate(set) var currentLocation: CLLocation?
    fileprivate(set) var completionHandler: LocationCallBack?
    fileprivate(set) var authorizationHandler: AuthorizationCallBack?

    var isLocationServicesEnabled: Bool {
        let status = CLLocationManager.authorizationStatus()
        return CLLocationManager.locationServicesEnabled() && (status == .authorizedAlways || status == .authorizedWhenInUse)
    }

    var isLocationDenied: Bool {
        let status = CLLocationManager.authorizationStatus()
        return status == .denied || status == .restricted
    }

    var locationStatus: CLAuthorizationStatus {
        return CLLocationManager.authorizationStatus()
    }

    func requestWhenInUseAuthorization(_ completionHandler: AuthorizationCallBack? = nil) {

        // hook completion handler
        authorizationHandler = completionHandler

        manager.delegate = self
        manager.requestWhenInUseAuthorization()
    }

    func fetchCurrentLocation(_ completionHandler: LocationCallBack? = nil) {
                
        // if location services are disabled send back nil
        if !isLocationServicesEnabled {
            completionHandler?(nil, nil)
            return
        }

        // update and send back location
        self.completionHandler = completionHandler
        startLocationManager()
    }

    func lookUp(currentLocation: CLLocation, completionHandler: @escaping (CLPlacemark?)
        -> Void ) {
        
        let geocoder = CLGeocoder()
        
        // Look up the location and pass it to the completion handler
        geocoder.reverseGeocodeLocation(currentLocation) { (placemarks, error) in
            if error == nil {
                let firstLocation = placemarks?[0]
                completionHandler(firstLocation)
            } else {
                // An error occurred during geocoding.
                completionHandler(nil)
            }
        }
    }

    fileprivate func startLocationManager() {
        
        // start updating location
        guard isLocationServicesEnabled else { return }
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestLocation()
        manager.startUpdatingLocation()
    }

    
    func stopLocationManager() {

        // clear any pending completion handler
        completionHandler = nil
        
        // stop updating
        manager.stopUpdatingLocation()
    }
}


extension LocationManager: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {

        // fire completion handler if any
        authorizationHandler?(status)

        // make sure completion handler is called just once
        authorizationHandler = nil
        
        status == .denied ? stopLocationManager() : startLocationManager()
    }

    

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations.last
        completionHandler?(currentLocation, nil)
        guard let _ = locations.last else { return }
        stopLocationManager()
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
        
        // failed, send back error and the previously saved user location
        completionHandler?(currentLocation, error as NSError?)
    }
}


extension LocationManager {
    @objc func getCurrentLocation() {
        guard LocationManager.shared.isLocationServicesEnabled else { return }
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        manager.requestLocation()
    }
}
