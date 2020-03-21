//
//  WeatherCell.swift
//  Weather App
//
//  Created by Ahmad Jabri on 21/03/2020.
//  Copyright © 2020 Ahmad Jabri. All rights reserved.
//

import UIKit

protocol WeatherPresentable {
    var title: String? { get }
    var weatherObject: WeatherObject { get }
}

class WeatherCell: UITableViewCell {
    
    var item : WeatherPresentable? {
        didSet {
            configureView()
        }
    }
    
    @IBOutlet private (set) weak var labelTitle: UILabel?
    @IBOutlet private (set) weak var labelWeatherDescription: UILabel?
    @IBOutlet private (set) weak var labelWeatherDescriptionValue: UILabel?
    @IBOutlet private (set) weak var labelMinTemp: UILabel?
    @IBOutlet private (set) weak var labelMinTempValue: UILabel?
    @IBOutlet private (set) weak var labelMaxTemp: UILabel?
    @IBOutlet private (set) weak var labelMaxTempValue: UILabel?
    @IBOutlet private (set) weak var labelWind: UILabel?
    @IBOutlet private (set) weak var labelWindValue: UILabel?
    
    
}

private extension WeatherCell {
    func configureView() {
        guard let item = item else { return }
        labelTitle?.text = item.title
        labelWeatherDescription?.text = "Weather Description:"
        labelWeatherDescriptionValue?.text = item.weatherObject.weather?.first?.description
        labelMinTemp?.text = "Min Temp:"
        labelMinTempValue?.text = "\(item.weatherObject.temp?.min ?? 0)"
        labelMaxTemp?.text = "Max Temp:"
        labelMaxTempValue?.text = "\(item.weatherObject.temp?.max ?? 0)"
        labelWind?.text = "Wind Speed"
        labelWindValue?.text = "\(item.weatherObject.wind?.speed ?? 0)"
    }
}
