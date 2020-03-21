//
//  UIColorExtensions.swift
//  Weather App
//
//  Created by Ahmad Jabri on 21/03/2020.
//  Copyright © 2020 Ahmad Jabri. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat = 1.0) {
        self.init(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha)
    }
}

extension UIColor {
    
    // main theme color
    static let cayanColor = UIColor(39.0, 205.0, 190.0)
}
