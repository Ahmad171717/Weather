//
//  DequeueReusable.swift
//  Weather App
//
//  Created by Ahmad Jabri on 21/03/2020.
//  Copyright © 2020 Ahmad Jabri. All rights reserved.
//

import UIKit

protocol DequeueReusable {
    static func dequeueReusableCell(in view: UIView, indexPath: IndexPath) -> Self
}

protocol DequeueReusableSupplementaryView {
    static func dequeueReusableSupplementaryView(in view: UIView, kind: String, indexPath: IndexPath) -> Self
}

extension UITableViewCell: DequeueReusable { }

extension DequeueReusable where Self: UITableViewCell {
    
    static func dequeueReusableCell(in view: UIView, indexPath: IndexPath) -> Self {
        
        guard let tableView = view as? UITableView, let cell = tableView.dequeueReusableCell(withIdentifier: Self.identifier, for: indexPath) as? Self else { return Self() }
        return cell
    }
}



// Register cell functions
extension UITableView {
    func register<T: UITableViewCell>(_ : T.Type){
        register(T.self, forCellReuseIdentifier: T.identifier)
    }
    
    func registerNib<T: UITableViewCell>(_ : T.Type) {
        register(T.nib, forCellReuseIdentifier: T.identifier)
    }
}
