//
//  NavigationController.swift
//  HSEday
//
//  Created by Anton Danilov on 16.08.2018.
//  Copyright © 2018 Anton Danilov. All rights reserved.
//

import Foundation
import UIKit

class NavigationController: UINavigationController, MenuViewDelegate{
    
    var menuView : MenuView!{
        didSet{
            if menuView != nil{
                menuView.delegate = self
            }
        }
    }
    
    func didSelectButton(withTag: Int) {
        self.viewControllers.removeLast()
    }
    
    func pushViewController<T: UIViewController>(tag: Int, configure: ((T) -> Void)? = nil, animated: Bool){
        var identifier : ViewControllerIdentifier!
        switch tag {
        case 0:
            identifier = .mapView
        case 1:
            identifier = .facultyView
        case 2:
            identifier = .orgView
        case 3:
           identifier = .hseView
        case 4:
            identifier = .questView
        default:
            return
        }
        
        let storyboard = UIStoryboard(name: StoryboardIdentifier.main.rawValue)
        guard let controller = (identifier != nil
            ? storyboard.instantiateViewController(withIdentifier: identifier!.rawValue)
            : storyboard.instantiateInitialViewController()) as? T
            else { return assertionFailure("Invalid controller for storyboard \(storyboard).") }
        configure?(controller)
        pushViewController(controller, animated: animated)
        if viewControllers.count > 1{
            viewControllers.remove(at: viewControllers.count - 2)
        }
    }
}
