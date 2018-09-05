//
//  HseViewController.swift
//  HSEday
//
//  Created by Anton Danilov on 20.08.2018.
//  Copyright © 2018 Anton Danilov. All rights reserved.
//

import UIKit
import AVFoundation

class HseViewController: UIViewController {
    
    var menuView : MenuView!
    
    @IBOutlet weak var hseImageView: UIImageView!
    
    @IBOutlet weak var hseDescription: UILabel!

    @IBOutlet weak var hseContacts: UITextView!
    
    @IBOutlet weak var hseImageHeight: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationItem()
        menuView = Bundle.main.loadNibNamed("MenuView", owner: MenuView.self() , options: nil)?.first as! MenuView
        self.view.addSubview(menuView)
        
        hseDescription.text = "Один из лучших вузов социально-экономического профиля в России. НИУ ВШЭ готовит высококлассных востребованных специалистов не только в области экономеческих, социальных наук и менеджмента, но и по гумантирным, физико-математическим, физическим направлениям, дизайну и реламе.\n\nСегодня Высшая школа экономики - это:\n>4 кампуса(Москва, Санкт-Петербург, Нижний Новогород, Пермь)\n>20000 студентов"
        hseImageView.image = UIImage(named: "ВШЭ")
        hseImageHeight.constant = imageWithImage(width: hseImageView.frame.width , image: hseImageView.image!)
        hseContacts.text = "+79104194939\nhttp://www.hse.ru\nhse.inc@gmail.com"
        
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        
        menuView.frame = view.bounds
        menuView.frame.origin.y = -view.bounds.height
        menuView.delegate = self
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension HseViewController: Routable, MenuViewDelegate{
    func didSelectButton(withTag: Int) {
        switch withTag {
        case 0:
            show(storyboard: StoryboardIdentifier.main, identifier: ViewControllerIdentifier.mapView, configure: nil)
        case 1:
            show(storyboard: StoryboardIdentifier.main, identifier: ViewControllerIdentifier.facultyView, configure: nil)
        case 2:
            show(storyboard: StoryboardIdentifier.main, identifier: ViewControllerIdentifier.orgView, configure: nil)
        case 3:
            animate(sender: self.menuView)
        case 4:
            show(storyboard: StoryboardIdentifier.main, identifier: ViewControllerIdentifier.questView, configure: nil)
        default:
            show(storyboard: StoryboardIdentifier.main, identifier: ViewControllerIdentifier.mapView, configure: nil)
        }
    }
    func setNavigationItem(){
        let menuBarItem = UIBarButtonItem(image: UIImage(named: "menu"), style: .plain, target: self, action: #selector(menuButtonPressed))
        menuBarItem.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = menuBarItem
    }
    @IBAction func menuButtonPressed(_ sender: Any) {
        let barButtonItem = sender as! UIBarButtonItem
        if barButtonItem.image == UIImage(named:"exit"){
            barButtonItem.image = UIImage(named:"menu")
        }
        else {barButtonItem.image = UIImage(named:"exit")}
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

