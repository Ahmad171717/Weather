//
//  WeatherHeaderView.swift
//  Weather App
//
//  Created by Ahmad Jabri on 21/03/2020.
//  Copyright © 2020 Ahmad Jabri. All rights reserved.
//

import UIKit

class WeatherHeaderView: UIView {
    
    var title = "" {
        didSet {
            configureView()
        }
    }
    @IBOutlet private (set) weak var labelTitle: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureView()
    }
}

extension WeatherHeaderView {
    func configureView() {
        labelTitle?.text = title
    }
}
