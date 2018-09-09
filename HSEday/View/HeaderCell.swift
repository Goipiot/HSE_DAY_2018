//
//  HeaderCell.swift
//  HSEday
//
//  Created by Anton Danilov on 09.09.2018.
//  Copyright © 2018 Anton Danilov. All rights reserved.
//

import UIKit
protocol HeaderCellDelegate: class{
    func didSelectHeader(atIndex index: Int, headerCell: HeaderCell )
}
class HeaderCell: UIView{
    weak var delegate: HeaderCellDelegate?
    var index: Int!
    
    @IBOutlet weak var separatorHeight: NSLayoutConstraint!
    @IBOutlet weak var separator: UIView!
    
    @IBOutlet weak var headerName: UILabel!
    @IBOutlet weak var headerImage: UIImageView!
    var isPicked: Bool = true
    func rotateView(){
        if isPicked{
            UIView.animate(withDuration: 0.3, delay: 0, options:.curveEaseOut, animations: {
                self.headerImage.transform = CGAffineTransform(rotationAngle: .pi/2)
            }, completion: nil)
        }
        else{
            UIView.animate(withDuration: 0.3, delay: 0, options:.curveEaseOut, animations: {
                self.headerImage.transform = CGAffineTransform.identity
            }, completion: nil)
        }
        isPicked = !isPicked
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        let tabGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapping))
        self.addGestureRecognizer(tabGesture)
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 0
        layer.shadowRadius = 5
        clipsToBounds = false
        separatorHeight.constant = 0.5
    }
    
    func addShadow(){
        layer.shadowOpacity = 1
        separator.isHidden = true
    }
    func removeShadow(){
        layer.shadowOpacity = 0
        separator.isHidden = false
    }
    
    @objc func handleTapping(){
        
        delegate?.didSelectHeader(atIndex: index, headerCell: self)
        rotateView()
    }
}
