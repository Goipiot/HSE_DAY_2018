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
        print("hui")
        self.viewControllers.removeLast()
    }

}
