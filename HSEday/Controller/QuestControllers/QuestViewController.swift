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
    
    @IBOutlet weak var questDescription: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "Helvetica-Light", size: 20)!]
        setNavigationItem()
        menuView = Bundle.main.loadNibNamed("MenuView", owner: MenuView.self() , options: nil)?.first as! MenuView
        self.view.addSubview(menuView)
        
        questDescription.text = "Приходи 13 сентября на квест «Путь Первака» от Ингруп СтС и стань настоящим Вышкинцем!\nТочки квеста отмечены на карте в приложении — пройди все и получи свой приз в шатре выдачи подарков! А если с телефоном что-то пойдет не так, там же ты всегда сможешь получить бумажную версию карты.\nДо встречи на Дне Вышки!\n\nЗа прогрессом можно следить на карте приложения"

        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        
        menuView.frame = view.bounds
        menuView.frame.origin.y = -view.bounds.height
        menuView.delegate = self
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.hidesBarsOnSwipe = false
    }

}
extension QuestViewController: Routable, MenuViewDelegate{
    func didSelectButton(withTag: Int) {
        switch withTag {
        case 0:
            show(storyboard: StoryboardIdentifier.main, identifier: ViewControllerIdentifier.mapView, configure: nil)
        case 1:
            show(storyboard: StoryboardIdentifier.main, identifier: ViewControllerIdentifier.facultyView, configure: nil)
        case 2:
            show(storyboard: StoryboardIdentifier.main, identifier: ViewControllerIdentifier.orgView, configure: nil)
        case 3:
            show(storyboard: StoryboardIdentifier.main, identifier: ViewControllerIdentifier.hseView, configure: nil)
        case 4:
            animate(sender: self.menuView)
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
