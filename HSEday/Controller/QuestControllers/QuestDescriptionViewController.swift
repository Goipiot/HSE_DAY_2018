//
//  QuestDescriptionViewController.swift
//  HSEday
//
//  Created by Anton Danilov on 22.08.2018.
//  Copyright © 2018 Anton Danilov. All rights reserved.
//

import UIKit
import AVFoundation

class QuestDescriptionViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var questScrollView: UIScrollView!
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var questImage: UIImageView!
    @IBOutlet weak var questLabel: UILabel!
    var quest : Quest!
    
    @IBOutlet weak var questDescription: UILabel!
    @IBOutlet weak var questTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "Helvetica-Light", size: 20)!]
        questTextField.keyboardType = UIKeyboardType.numbersAndPunctuation
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let imageName = "\((quest?.number)!)" as String
        
        questImage.image = UIImage(named: imageName)
        questLabel.text = quest?.name
        questDescription.text = quest?.description
        imageHeightConstraint.constant = imageWithImage(width: questImage.frame.width , image: questImage.image!)
        

        // Do any additional setup after loading the view.
    }
    func imageWithImage(width: CGFloat, image: UIImage) -> CGFloat{
        let boundingRect = CGRect(x: 0, y: 0, width: width, height: CGFloat(MAXFLOAT))
        let rect = AVMakeRect(aspectRatio: image.size, insideRect: boundingRect)
        return rect.size.height
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func codePassed(_ sender: UITextField) {
        statusLabel.isHidden = false
        if sender.text == quest.passcode{
            UserDefaults.standard.set(true, forKey: quest.number)
            statusLabel.textColor = UIColor.green
            statusLabel.text = "Правильно"
        }
        else{
            statusLabel.textColor = UIColor.red
            statusLabel.text = "Неправильно"
        }
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        questScrollView.setContentOffset(CGPoint(x: 0, y: questImage.bounds.size.height), animated: true)
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    override func viewWillDisappear(_ animated : Bool) {
        super.viewWillDisappear(animated)
        
        if (self.isMovingFromParentViewController){
            if questTextField.text == quest.passcode{
                UserDefaults.standard.set(true, forKey: quest.number)
            }
        }
    }
    @available(iOS 10.0, *)
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        questScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
}
