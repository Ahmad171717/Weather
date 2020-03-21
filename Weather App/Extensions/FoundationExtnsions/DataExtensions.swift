//
//  DataExtensions.swift
//  Weather App
//
//  Created by Ahmad Jabri on 21/03/2020.
//  Copyright © 2020 Ahmad Jabri. All rights reserved.
//

import Foundation

extension Data {
    var jsonSerializd: Any? {
        return try? JSONSerialization.jsonObject(with: self, options: .mutableContainers)
    }
}
