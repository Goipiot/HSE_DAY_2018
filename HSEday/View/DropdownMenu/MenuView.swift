//
//  MenuView.swift
//  HSEday
//
//  Created by Anton Danilov on 15.08.2018.
//  Copyright © 2018 Anton Danilov. All rights reserved.
//

import Foundation
import UIKit

protocol MenuViewDelegate : class{
    func didSelectButton(withTag: Int)
}

class MenuView : UIView{
    
    weak var delegate: MenuViewDelegate?
    
    @IBAction func buttonPressed(_ sender: Any) {
        let button = sender as! UIButton
        let tag = button.tag
        delegate?.didSelectButton(withTag: tag)
    }
}
