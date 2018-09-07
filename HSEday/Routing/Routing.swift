//
//  Routing.swift
//  HSEday
//
//  Created by Sergey on 8/15/18.
//  Copyright © 2018 Anton Danilov. All rights reserved.
//

import Foundation
import UIKit

protocol Routable {
    //SANYA USE THIS
    func present<T: UIViewController>(storyboard: StoryboardIdentifier, identifier: ViewControllerIdentifier?, animated: Bool, modalPresentationStyle: UIModalPresentationStyle?, configure: ((T) -> Void)?, completion: ((T) -> Void)?)
    func show<T: UIViewController>(storyboard: StoryboardIdentifier, identifier: ViewControllerIdentifier?, configure: ((T) -> Void)?)
    func showDetailViewController<T: UIViewController>(storyboard: StoryboardIdentifier, identifier: ViewControllerIdentifier?, configure: ((T) -> Void)?)
}

extension Routable where Self: UIViewController{
    
    func present<T: UIViewController>(storyboard: StoryboardIdentifier, identifier: ViewControllerIdentifier? = nil, animated: Bool = true, modalPresentationStyle: UIModalPresentationStyle? = nil, configure: ((T) -> Void)? = nil, completion: ((T) -> Void)? = nil) {
        let storyboard = UIStoryboard(name: storyboard.rawValue)
        
        guard let controller = (identifier != nil
            ? storyboard.instantiateViewController(withIdentifier: identifier!.rawValue)
            : storyboard.instantiateInitialViewController()) as? T
            else { return assertionFailure("Invalid controller for storyboard \(storyboard).") }
        
        if let modalPresentationStyle = modalPresentationStyle {
            controller.modalPresentationStyle = modalPresentationStyle
        }
        
        configure?(controller)
        
        present(controller, animated: animated) {
            completion?(controller)
        }
    }
    
    
    func show<T: UIViewController>(storyboard: StoryboardIdentifier, identifier: ViewControllerIdentifier? = nil, configure: ((T) -> Void)? = nil) {
        let storyboard = UIStoryboard(name: storyboard.rawValue)
        
        guard let controller = (identifier != nil
            ? storyboard.instantiateViewController(withIdentifier: identifier!.rawValue)
            : storyboard.instantiateInitialViewController()) as? T
            else { return assertionFailure("Invalid controller for storyboard \(storyboard).") }
        
        configure?(controller)
        
        show(controller, sender: self)
    }
    
    func showDetailViewController<T: UIViewController>(storyboard: StoryboardIdentifier, identifier: ViewControllerIdentifier? = nil, configure: ((T) -> Void)? = nil) {
        let storyboard = UIStoryboard(name: storyboard.rawValue)
        
        guard let controller = (identifier != nil
            ? storyboard.instantiateViewController(withIdentifier: identifier!.rawValue)
            : storyboard.instantiateInitialViewController()) as? T
            else { return assertionFailure("Invalid controller for storyboard \(storyboard).") }
        
        configure?(controller)
        
        showDetailViewController(controller, sender: self)
    }
}

extension UIStoryboard {
    convenience init(name: String) {
        self.init(name: name, bundle: nil)
    }
}


