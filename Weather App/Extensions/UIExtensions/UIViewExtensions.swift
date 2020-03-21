//
//  UIViewExtensions.swift
//  Weather App
//
//  Created by Ahmad Jabri on 21/03/2020.
//  Copyright © 2020 Ahmad Jabri. All rights reserved.
//

import UIKit

extension UIView {
    
    // instantiate view from nib
    class func instantiateFromNib<T: UIView>() -> T? {
        return nib.instantiate(withOwner: nil, options: nil).first as? T
    }
    
    // get nib from bundle
    class var nib: UINib {
        return UINib(nibName: nibName, bundle: nil)
    }
    
    // get nib name
    class var nibName: String {
        return identifier
    }
}

extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
}
