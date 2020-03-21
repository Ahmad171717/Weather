//
//  Alert.swift
//  Weather App
//
//  Created by Ahmad Jabri on 21/03/2020.
//  Copyright © 2020 Ahmad Jabri. All rights reserved.
//

import UIKit

class Alert: NSObject {
    
    let style: UIAlertController.Style
    var title: String?
    var message: String?
    var actions: [UIAlertAction] = []
    
    init(style: UIAlertController.Style) {
        self.style = style
    }
    
    static func alert(_ title: String = "", message: String = "") -> Alert {
        return Alert(style: .alert).title(title).message(message)
    }
    
    static func sheet() -> Alert {
        return Alert(style: .actionSheet)
    }
    
    static func sheet(_ title: String) -> Alert {
        return sheet().title(title)
    }
    
    func title(_ title: String?) -> Alert {
        self.title = title
        return self
    }
    
    func message(_ message: String?) -> Alert {
        self.message = message
        return self
    }
    
    @discardableResult func ok(_ button: String) -> Alert {
        return ok(button: button, callback: nil)
    }
    
    func ok(button: String, callback: VoidClosure?) -> Alert {
        actions.append(UIAlertAction(title: button, style: .default) { _ in
            callback?()
        })
        return self
    }
    
    func cancel(_ button: String) -> Alert {
        return cancel(button, nil)
    }
    
    func cancel(_ button: String, _ callback: VoidClosure?) -> Alert {
        actions.append(UIAlertAction(title: button, style: .cancel) { _ in
            callback?()
        })
        return self
    }
    
    func destruct(_ button: String) -> Alert {
        return destruct(button, nil)
    }
    
    func destruct(_ button: String, _ callback: VoidClosure?) -> Alert {
        actions.append(UIAlertAction(title: button, style: .destructive) { _ in
            callback?()
        })
        return self
    }
    
    // to display/ present the alert
    func show() {
        
        if actions.isEmpty {
            ok("Ok")
        }
        
        // create alert
        let viewController = UIAlertController(title: title, message: message, preferredStyle: style)
        actions.forEach { viewController.addAction($0) }
        
        DispatchQueue.main.async {
            Alert.present(viewController)
        }
    }
    
    // alert with ok button only with action
    static func ok(_ title: String, _ message: String?, _ callback: @escaping VoidClosure) {
        alert(title).message(message).ok(button: "Ok", callback: callback).show()
    }
    
    // alert with ok button only without action
    static func ok(_ title: String, _ message: String?) {
        alert(title).message(message).ok("Ok").show()
    }
    
    // alert with ok and cancel button, with action
    static func okcancel(_ title: String, _ message: String?, _ button: String = "Ok", _ callback: @escaping VoidClosure) {
        alert(title).message(message).ok(button: button, callback: callback).cancel("Cancel").show()
    }
    
    // alert with yes and no button, with action for ok
    static func yesno(_ title: String, _ message: String?, _ button: String = "Yes", _ callback: @escaping VoidClosure) {
        alert(title).message(message).ok(button: button, callback: callback).cancel("No").show()
    }
    
    // to present the alert
    fileprivate static func present(_ viewController: UIViewController) {
        delay(10) {
            if let topController = topController() {
                topController.present(viewController, animated: true, completion: nil)
            }
            
        }
    }
}
