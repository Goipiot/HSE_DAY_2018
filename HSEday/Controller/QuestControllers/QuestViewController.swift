//
//  QuestViewController.swift
//  HSEday
//
//  Created by Anton Danilov on 20.08.2018.
//  Copyright © 2018 Anton Danilov. All rights reserved.
//

import UIKit

class QuestViewController: UIViewController {
    
    var menuView : MenuView!
    
    @IBOutlet weak var insButton: UIButton!
    @IBOutlet weak var questDescription: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "Helvetica-Light", size: 20)!]
        setNavigationItem()
        menuView = Bundle.main.loadNibNamed("MenuView", owner: MenuView.self() , options: nil)?.first as! MenuView
        menuView.delegate = self
        self.view.addSubview(menuView)
        
//        questDescription.text = ""

        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        
        menuView.frame = view.bounds
        menuView.frame.origin.y = -view.bounds.height

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.hidesBarsOnSwipe = false
    }
    @IBAction func instButtonClicked(_ sender: UIButton) {
        do {
            try UIApplication.shared.openURL(NSURL(string: "https://www.instagram.com/lovjutsu/")! as URL)
        }
    }
    
}
extension QuestViewController: Routable, MenuViewDelegate{
    func didSelectButton(withTag: Int) {
        if withTag != 4{
            (self.navigationController as! NavigationController).pushViewController(tag: withTag, animated: true)
        } else{
            animate(sender: self.menuView)
        }
    }
    func setNavigationItem(){
        let menuBarItem = UIBarButtonItem(image: UIImage(named: "menu"), style: .plain, target: self, action: #selector(menuButtonPressed))
        menuBarItem.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = menuBarItem
    }
    @IBAction func menuButtonPressed(_ sender: Any) {
        let barButtonItem = sender as! UIBarButtonItem
        if barButtonItem.image == UIImage(named:"cancel"){
            barButtonItem.image = UIImage(named:"menu")
        }
        else {barButtonItem.image = UIImage(named:"cancel")}
        animate(sender: menuView)
    }
    func animate(sender: UIView){
        if sender.frame.origin.y == 0{
            UIView.animate(withDuration: 0.8,
                           delay: 0,
                           usingSpringWithDamping: 1,
                           initialSpringVelocity: 0,
                           options: .curveEaseOut,
                           animations: {
                            
                            sender.frame.origin.y = -self.view.bounds.height
                            
            }, completion: nil)
        }
        else{
            UIView.animate(withDuration: 0.8,
                           delay: 0,
                           usingSpringWithDamping: 1,
                           initialSpringVelocity: 0,
                           options: .curveEaseOut,
                           animations: {
                            
                            sender.frame.origin.y = 0
            }, completion: nil)
        }
    }
}
