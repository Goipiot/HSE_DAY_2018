//
//  PopoverViewController.swift
//  HSEday
//
//  Created by Anton Danilov on 21.08.2018.
//  Copyright © 2018 Anton Danilov. All rights reserved.
//

import UIKit
protocol PopoverViewControllerDelegate: class{
    func didSelectPointButton()
}
class PopoverViewController: UIViewController {
    
    @IBOutlet weak var questDetailsButton: UIButton!
    var quest : Quest!
    var point: MapPoint!
    var isQuestButtonClicked: Bool = false
    weak var delegate : PopoverViewControllerDelegate?
    
    @IBOutlet weak var questName: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "Helvetica-Light", size: 20)!]
        
        if isQuestButtonClicked{
            questName.setTitle("\(quest.number). \(quest.name)", for: .normal)
        }
        else{
            questName.contentHorizontalAlignment = .center
            questName.setTitle("\(point.name)", for: .normal)
//            questDetailsButton.isHidden = true
            questName.isEnabled = false
        }
    }

    @IBAction func questDetailsButtonClicked(_ sender: UIButton) {
        dismiss(animated: false, completion: nil)
            delegate?.didSelectPointButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if isQuestButtonClicked{
            if UserDefaults.standard.bool(forKey: quest.number){
//                questDetailsButton.isHidden = true
                  questName.isEnabled = false
            }
        }
    }
}
