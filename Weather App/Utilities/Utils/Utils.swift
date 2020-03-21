//
//  Utils.swift
//  Weather App
//
//  Created by Ahmad Jabri on 21/03/2020.
//  Copyright © 2020 Ahmad Jabri. All rights reserved.
//

import UIKit
import CoreLocation

typealias GenericClosure<T> = (T) -> Void
typealias CityClosure = GenericClosure<[City]?>
typealias VoidClosure = () -> Void
typealias LocationCallBack = (_ location: CLLocation?, _ error: NSError?) -> Void
typealias AuthorizationCallBack = (_ status: CLAuthorizationStatus) -> Void

// find top most view controller
func topController() -> UIViewController? {
    
    // recursive follow
    func follow(_ from: UIViewController?) -> UIViewController? {
        if let to = (from as? UITabBarController)?.selectedViewController {
            return follow(to)
        } else if let to = (from as? UINavigationController)?.visibleViewController {
            return follow(to)
        } else if let to = from?.presentedViewController {
            return follow(to)
        } else {
            return from
        }
    }
    
    // use our own root since when we there is a
    // UIAlertController displaying, it's the
    // keywindow root
    let root = UIApplication.shared.keyWindow?.rootViewController
    
    return follow(root)
}

/**
 Delay a block with a number of milliseconds.
 - parameter delay: number of milliseconds to delay execution by.
 - parameter closure: the block to execute after delay
 */
let msecPerNsec: Int64 = 1000000
@discardableResult func delay(_ delay: Int64, _ closure:@escaping (() -> Void)) -> (() -> Void)? {
    var cancelled = false
    DispatchQueue.main.asyncAfter(
    deadline: DispatchTime.now() + Double((delay * msecPerNsec)) / Double(NSEC_PER_SEC)) {
        if !cancelled {
            closure()
        }
    }
    return {
        cancelled = true
    }
}
