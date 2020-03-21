//
//  Navigatable.swift
//  Weather App
//
//  Created by Ahmad Jabri on 21/03/2020.
//  Copyright © 2020 Ahmad Jabri. All rights reserved.
//

import UIKit

protocol Navigatable {}

extension UIViewController: Navigatable {}

extension Navigatable where Self: UIViewController {
    
    typealias UpdateHandler = (Self) -> Void
    
    static func push(storyBoard: UIStoryboard.Storyboard = .main, navigationController: UINavigationController? = nil, shouldPreventMultiplePushing: Bool = true, customTransition: CATransitionType? = nil, updateHandler: UpdateHandler? = nil) {
        
        // get the view controller to push
        let pushingController = instantiate(from: storyBoard)
        
        // push
        pushingController.push(navigationController: navigationController, shouldPreventMultiplePushing: shouldPreventMultiplePushing, customTransition: customTransition, updateHandler: updateHandler)
    }
    
    func push(navigationController: UINavigationController? = nil, shouldPreventMultiplePushing: Bool = true, customTransition: CATransitionType? = nil, updateHandler: UpdateHandler? = nil) {
        
        // abort if we dont have a navigation controller
        guard let currentNavigationController = navigationController ?? topController()?.navigationController else { return }
        
        // abort if we are inhibiting multiple pushes and if the top contoller is the controller we are trying to push
        guard !(shouldPreventMultiplePushing && type(of: topController() ?? UIViewController()) == type(of: self)) else { return }
        
        // update the controller to push
        updateHandler?(self)
        
        // push
        if let customTransistion = customTransition {
            currentNavigationController.addTransition(transitionType: customTransistion, duration: 0.3)
            currentNavigationController.pushViewController(self, animated: false)
        } else {
            currentNavigationController.pushViewController(self, animated: true)
        }
    }
    
    static func present(storyBoard: UIStoryboard.Storyboard = .main, shouldEmbedInNavigationController: Bool = true, shouldPreventMultiplePresenting: Bool = true, updateHandler: UpdateHandler? = nil) {
        
        // get the view controller to present
        let presentingController = instantiate(from: storyBoard)
        
        // we are presenting controller inside a base navigation controller
        presentingController.present(shouldPreventMultiplePresenting: shouldPreventMultiplePresenting, shouldEmbedInNavigationController: shouldEmbedInNavigationController, updateHandler: updateHandler)
    }
    
    func present(shouldPreventMultiplePresenting: Bool = true, shouldEmbedInNavigationController: Bool = true, updateHandler: UpdateHandler? = nil) {
        
        // abort if we dont have a controller which can present
        guard let topController = topController() else { return }
        
        // abort if we are inhibiting multiple presents and if the top contoller is the controller we are trying to present
        guard !(shouldPreventMultiplePresenting && type(of: topController) == type(of: self)) else { return }
        
        // update the controller to present
        updateHandler?(self)
        
        guard shouldEmbedInNavigationController else {
            
            // explictly to full screen to support ios 13
            modalPresentationStyle = .fullScreen
            
            // we are presenting controller without navigation controller.
            topController.present(self, animated: true, completion: nil)
            return
        }
        
        // explictly to full screen to support ios 13
        let controller = UINavigationController(rootViewController: self)
        controller.modalPresentationStyle = .fullScreen
        
        
        // we are presenting controller inside a base navigation controller
        topController.present(controller, animated: true, completion: nil)
    }
}
