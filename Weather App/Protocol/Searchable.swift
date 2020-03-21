//
//  Searchable.swift
//  Weather App
//
//  Created by Ahmad Jabri on 21/03/2020.
//  Copyright © 2020 Ahmad Jabri. All rights reserved.
//

import Foundation

protocol Searchable {
    func passesSearch(for key: String) -> Bool
}
