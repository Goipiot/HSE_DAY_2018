//
//  OrganizationTitleTableViewCell.swift
//  HSEday
//
//  Created by Sergey on 9/7/18.
//  Copyright © 2018 Anton Danilov. All rights reserved.
//

import Foundation
import UIKit

class OrganizationTitleTableViewCell: UITableViewCell{
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var dropdownArrowImageView: UIImageView!
    var isOpened = false
    
    func rotateArrow(){
        if isOpened{
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
                self.dropdownArrowImageView.transform = CGAffineTransform(rotationAngle: 0)
            }, completion: {_ in
                print("Hello")
                self.isOpened = false
            })
        } else {
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {
                self.dropdownArrowImageView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi / 2))
            }, completion: {_ in
                print("Goodbye")
                self.isOpened = true
            })
        }
    }
}
