//
//  Listable.swift
//  Weather App
//
//  Created by Ahmad Jabri on 21/03/2020.
//  Copyright © 2020 Ahmad Jabri. All rights reserved.
//


import UIKit

protocol Listable: Searchable {
    var listName: String { get }
}

extension Listable {
    func passesSearch(for key: String) -> Bool {
        return listName.localizedCaseInsensitiveContains(key)
    }
}
