//
//  UIStoryboardExtensions.swift
//  Weather App
//
//  Created by Ahmad Jabri on 21/03/2020.
//  Copyright © 2020 Ahmad Jabri. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    enum Storyboard: String {
        
        case main              = "Main"
    }
    
    convenience init(storyboard: Storyboard, bundle: Bundle? = nil) {
        self.init(name: storyboard.rawValue, bundle: bundle)
    }
}

