//
//  UIResponderExtensions.swift
//  Weather App
//
//  Created by Ahmad Jabri on 21/03/2020.
//  Copyright © 2020 Ahmad Jabri. All rights reserved.
//

import UIKit

protocol Identifiable {
    static var identifier: String { get }
}

extension UIResponder: Identifiable {
    static var identifier: String {
        return "\(self)"
    }
}
