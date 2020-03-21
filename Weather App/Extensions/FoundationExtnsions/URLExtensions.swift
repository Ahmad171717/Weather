//
//  URLExtensions.swift
//  Weather App
//
//  Created by Ahmad Jabri on 21/03/2020.
//  Copyright © 2020 Ahmad Jabri. All rights reserved.
//

import Foundation

extension URL {
    init?(jsonPath: String) {
        guard let path = Bundle.main.path(forResource: jsonPath, ofType: "json") else { return nil }
        self.init(fileURLWithPath: path)
    }
}
