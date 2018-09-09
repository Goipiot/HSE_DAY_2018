//
//  OrganizationDetailsViewController.swift
//  HSEday
//
//  Created by Anton Danilov on 26.08.2018.
//  Copyright © 2018 Anton Danilov. All rights reserved.
//

import UIKit
import AVFoundation

class OrganizationDetailsViewController: UIViewController {
    @IBOutlet weak var organizationImage: UIImageView!
    
    @IBOutlet weak var organizationImageHeight: NSLayoutConstraint!
    @IBOutlet weak var organizationDescription: UILabel!

    @IBOutlet weak var organizationContactDescription: UITextView!
    
    @IBOutlet weak var organizationContactLabel: UILabel!
    @IBOutlet weak var organizationNameLabel: UILabel!
    var org: Organization!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "Helvetica-Light", size: 20)!]

        organizationImage.image = UIImage(named: org.imageUrl)
        organizationNameLabel.text = org.name
        organizationDescription.text = org.description
        organizationContactDescription.text = org.link
        organizationImageHeight.constant = imageWithImage(width: organizationImage.frame.width , image: organizationImage.image!)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func imageWithImage(width: CGFloat, image: UIImage) -> CGFloat{
        let boundingRect = CGRect(x: 0, y: 0, width: width, height: CGFloat(MAXFLOAT))
        let rect = AVMakeRect(aspectRatio: image.size, insideRect: boundingRect)
        return rect.size.height
    }
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        navigationController?.hidesBarsOnSwipe = true
//    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
