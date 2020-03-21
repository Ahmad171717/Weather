//
//  ActivityIndicator.swift
//  Weather App
//
//  Created by Ahmad Jabri on 21/03/2020.
//  Copyright © 2020 Ahmad Jabri. All rights reserved.
//

import Foundation
import NVActivityIndicatorView

class LoadingIndicator: UIViewController, NVActivityIndicatorViewable {
    
    private var activityView: NVActivityIndicatorView?
    
    // singleton
    static let shared = LoadingIndicator()
    
    // show loading indicator
     func show() {
        let size = CGSize(width: 50, height: 50)
        startAnimating(size, message: "", type: .lineScalePulseOutRapid, color: .white, backgroundColor: .clear)
    }
    
    // dismiss loading indicator
    func dismiss() {
        stopAnimating()
        activityView?.removeFromSuperview()
    }
}
