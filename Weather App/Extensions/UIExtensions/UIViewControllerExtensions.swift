//
//  UIViewControllerExtensions.swift
//  Weather App
//
//  Created by Ahmad Jabri on 21/03/2020.
//  Copyright © 2020 Ahmad Jabri. All rights reserved.
//

import UIKit

protocol Instantiatable {
    static func instantiateInitalViewController(from storyboardIdentifier: UIStoryboard.Storyboard) -> Self
    static func instantiate(from storyboardIdentifier: UIStoryboard.Storyboard) -> Self
}

extension UIViewController: Instantiatable { }

extension Instantiatable where Self: UIViewController {
    
    static func instantiateInitalViewController(from storyboardIdentifier: UIStoryboard.Storyboard) -> Self {
        
        guard let viewController = UIStoryboard(storyboard: storyboardIdentifier).instantiateInitialViewController() as? Self else {
            return Self()
        }
        return viewController
    }
    
    static func instantiate(from storyboardIdentifier: UIStoryboard.Storyboard = .main) -> Self {
        
        guard let viewController = UIStoryboard(storyboard: storyboardIdentifier).instantiateViewController(withIdentifier: identifier) as? Self else {
            return Self()
        }
        return viewController
    }
}
