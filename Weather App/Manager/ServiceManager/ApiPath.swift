//
//  ApiPath.swift
//  Weather App
//
//  Created by Ahmad Jabri on 21/03/2020.
//  Copyright © 2020 Ahmad Jabri. All rights reserved.
//

import Foundation

enum ApiPath {
    
    case version
    
    var name: String {
        switch self {
        case .version: return "2.5"
        }
    }
}
