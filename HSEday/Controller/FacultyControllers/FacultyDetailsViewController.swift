//
//  FacultyDetailsViewController.swift
//  HSEday
//
//  Created by Anton Danilov on 17.08.2018.
//  Copyright © 2018 Anton Danilov. All rights reserved.
//

import UIKit
import AVFoundation

class FacultyDetailsViewController: UIViewController {
    @IBOutlet weak var fucultyImage: UIImageView!
    
    @IBOutlet weak var facultyName: UILabel!
    
    @IBOutlet weak var facultyDescription: UILabel!
    
    @IBOutlet weak var facultyDepartment: UILabel!
    
    @IBOutlet weak var facultyContacts: UITextView!
    
    
    @IBOutlet weak var facultyImageHeight: NSLayoutConstraint!
    var faculty: Faculty?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fucultyImage.image =  UIImage(named: (faculty?.imageUrl)!)
        facultyName.text = faculty?.name
        facultyDepartment.text = faculty?.departments
        facultyDescription.text = faculty?.description
        facultyContacts.text = faculty?.link
        
        self.navigationController?.navigationBar.tintColor = .white
        facultyImageHeight.constant = imageWithImage(width: fucultyImage.frame.width , image: fucultyImage.image!)
        
    }
    func imageWithImage(width: CGFloat, image: UIImage) -> CGFloat{
        let boundingRect = CGRect(x: 0, y: 0, width: width, height: CGFloat(MAXFLOAT))
        let rect = AVMakeRect(aspectRatio: image.size, insideRect: boundingRect)
        return rect.size.height
    }
}

