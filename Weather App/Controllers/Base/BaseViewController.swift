//
//  BaseViewController.swift
//  Weather App
//
//  Created by Ahmad Jabri on 21/03/2020.
//  Copyright © 2020 Ahmad Jabri. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var shouldHideNavigationBar: Bool {
        return false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // hide navigation bar if required
        navigationController?.setNavigationBarHidden(shouldHideNavigationBar, animated: false)
    }
}
