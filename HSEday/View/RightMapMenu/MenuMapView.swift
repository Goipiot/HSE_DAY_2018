//
//  MenuMapView.swift
//  HSEday
//
//  Created by Anton Danilov on 16.08.2018.
//  Copyright © 2018 Anton Danilov. All rights reserved.
//

import Foundation
import UIKit

protocol MenuMapViewDelegate : class{
    func didSelectMenuMapButton(withTag tag: Int)
}

class MenuMapView: UIView{
    weak var delegate: MenuMapViewDelegate?
    @IBAction func menuMapButtonClicked(_ sender: UIButton) {
        if sender.alpha == 1{
            sender.alpha = 0.5
        }
        else{
            sender.alpha = 1
        }
        delegate?.didSelectMenuMapButton(withTag: sender.tag)
    }
    
    
}
