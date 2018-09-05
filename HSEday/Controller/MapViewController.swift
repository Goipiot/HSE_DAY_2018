//
//  ViewController.swift
//  HSEday
//
//  Created by Anton Danilov on 13.08.2018.
//  Copyright © 2018 Anton Danilov. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate, UIPopoverPresentationControllerDelegate{
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
    var menuView : MenuView!
    var menuMapView: MenuMapView!
    var pointButton: PointButton!
    var questArray = [Quest]()
    var questTag: Int = 0
    var mapMeetingPoints = [MapPoint]()
    var mapSportPoints = [MapPoint]()
    var mapEntPoints  = [MapPoint]()
    var mapLecturesPoints = [MapPoint]()
    
    
    @IBOutlet weak var scoreBarButtonItem: UIBarButtonItem!
    //    var buttonView: ButtonView!
    
    deinit {
        print("gone")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self

        
        if UserDefaults.isFirstLaunch(){
            let alert = UIAlertController(title: "Квест",
                                          message: "Приходи 13 сентября на квест «Путь Первака» от Ингруп СтС и стань настоящим Вышкинцем!Точки квеста отмечены на карте в приложении — пройди все и получи свой приз в шатре выдачи подарков! А если с телефоном что-то пойдет не так, там же ты всегда сможешь получить бумажную версию карты.До встречи на Дне Вышке!",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Понятно", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        }

        
        (self.navigationController as! NavigationController).menuView = menuView
       
        
        
        
        setNavigationItem()
        getDataFromJson()
        createQuestButtons()
        createPointButtons()
        
        menuView = Bundle.main.loadNibNamed("MenuView", owner: MenuView.self , options: nil)?.first as! MenuView
        self.view.addSubview(menuView)
        menuView.delegate = self
        menuMapView = Bundle.main.loadNibNamed("MapMenuView", owner: MenuMapView.self , options: nil)?.first as! MenuMapView
        self.view.addSubview(menuMapView)
        menuMapView.delegate = self

        scrollView.contentSize = imageView.bounds.size
        scrollView.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.RawValue(UInt8(UIViewAutoresizing.flexibleWidth.rawValue) | UInt8(UIViewAutoresizing.flexibleHeight.rawValue)))
        scrollView.contentOffset = CGPoint(x: 350, y: 300)
        
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        var completeStagesCounter = 0
        for subview in imageView.subviews{
            if let button = subview as? PointButton, button.tag < 18{
                if UserDefaults.standard.bool(forKey: String(describing: button.tag)){
                    completeStagesCounter+=1
                    print(button.tag)
                    button.setImage(UIImage(named: "PervakDone"), for: .normal)
                }
            }
        }
        scoreBarButtonItem.title = "\(completeStagesCounter)/17"
        if completeStagesCounter == 17{
            let alert = UIAlertController(title: nil,
                                          message: "Поздравляю, ты прошел квест! Теперь ты настоящий ПЕРВАК. Скорее иди за своими подарками и подпишись на иснтаграм @lovjutsu",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Хорошо", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    func createQuestButtons(){
        for qb in questArray{
            let number = Int(qb.number)!
            let pointButton = Bundle.main.loadNibNamed("PointButtonView", owner: PointButton.self, options: nil)?.first as! PointButton
            imageView.addSubview(pointButton)
            pointButton.setImage(UIImage(named:"Pervak"), for: .normal)
            pointButton.addTarget(self, action:#selector(questButtonClicked), for: UIControlEvents.touchUpInside)
            pointButton.tag = number
            let x = Int(questArray[number].x)!
            let y = Int(questArray[number].y)! - 13
            pointButton.center = CGPoint(x: x, y: y)
            pointButton.bounds.size = CGSize(width: 26, height: 26)
            pointButton.titleLabel?.isEnabled = false
            if number == 16{
                break
            }
        }
    }
    
    func createPointButtons(){
        var i = 0
        for point in mapEntPoints{
            let pointButton = Bundle.main.loadNibNamed("PointButtonView", owner: PointButton.self, options: nil)?.first as! PointButton
            imageView.addSubview(pointButton)
            pointButton.setImage(UIImage(named:"Myach"), for: .normal)
            pointButton.addTarget(self, action:#selector(mapPointButtonClicked), for: UIControlEvents.touchUpInside)
            pointButton.tag = 100+i
            let x = point.x
            let y = point.y
            pointButton.center = CGPoint(x: x, y: y)
            pointButton.bounds.size = CGSize(width: 32, height: 26)
            pointButton.titleLabel?.isEnabled = false
            i+=1
        }
        i = 0
        for point in mapSportPoints{
            let pointButton = Bundle.main.loadNibNamed("PointButtonView", owner: PointButton.self, options: nil)?.first as! PointButton
            imageView.addSubview(pointButton)
            pointButton.setImage(UIImage(named:"Shater"), for: .normal)
            pointButton.addTarget(self, action:#selector(mapPointButtonClicked), for: UIControlEvents.touchUpInside)
            pointButton.tag = 200+i
            let x = point.x
            let y = point.y
            pointButton.center = CGPoint(x: x, y: y)
            pointButton.bounds.size = CGSize(width: 26, height: 26)
            pointButton.titleLabel?.isEnabled = false
            i+=1
        }
        i = 0
        for point in mapMeetingPoints{
            let pointButton = Bundle.main.loadNibNamed("PointButtonView", owner: PointButton.self, options: nil)?.first as! PointButton
            imageView.addSubview(pointButton)
            pointButton.setImage(UIImage(named:"Mikrofon"), for: .normal)
            pointButton.addTarget(self, action:#selector(mapPointButtonClicked), for: UIControlEvents.touchUpInside)
            pointButton.tag = 300+i
            let x = point.x
            let y = point.y
            pointButton.center = CGPoint(x: x, y: y)
            pointButton.bounds.size = CGSize(width: 26, height: 26)
            pointButton.titleLabel?.isEnabled = false
            i+=1
        }
        i = 0
        for point in mapLecturesPoints{
            let pointButton = Bundle.main.loadNibNamed("PointButtonView", owner: PointButton.self, options: nil)?.first as! PointButton
            imageView.addSubview(pointButton)
            pointButton.setImage(UIImage(named:"List"), for: .normal)
            pointButton.addTarget(self, action:#selector(mapPointButtonClicked), for: UIControlEvents.touchUpInside)
            pointButton.tag = 400+i
            let x = point.x
            let y = point.y
            pointButton.center = CGPoint(x: x, y: y)
            pointButton.bounds.size = CGSize(width: 26, height: 26)
            pointButton.titleLabel?.isEnabled = false
            i+=1
        }
    }
    @IBAction func questButtonClicked(_ sender: UIButton) {
        let popoverViewController = storyboard?.instantiateViewController(withIdentifier: "popoverView") as! PopoverViewController
        popoverViewController.modalPresentationStyle = .popover
        popoverViewController.preferredContentSize = CGSize(width: 200, height: 40)
        popoverViewController.quest = questArray[sender.tag-1]
        popoverViewController.isQuestButtonClicked = true
        questTag = sender.tag-1
        popoverViewController.delegate = self

        if let popoverPresentationController = popoverViewController.popoverPresentationController{
            popoverPresentationController.delegate = self
            popoverPresentationController.sourceView = sender as! PointButton
            popoverPresentationController.sourceRect = sender.bounds
            popoverPresentationController.permittedArrowDirections = [.down]
            popoverPresentationController.backgroundColor = popoverViewController.view.backgroundColor
            present(popoverViewController, animated: true, completion: nil)            
        }
    }
    
    
    @IBAction func mapPointButtonClicked(_ sender: PointButton) {
        let popoverViewController = storyboard?.instantiateViewController(withIdentifier: "popoverView") as! PopoverViewController
        popoverViewController.modalPresentationStyle = .popover
        popoverViewController.preferredContentSize = CGSize(width: 300, height: 60)
        popoverViewController.isQuestButtonClicked = false
        print(sender.tag)
        if sender.tag >= 100&&sender.tag < 200{
            popoverViewController.point  = mapEntPoints[sender.tag - 100]
        }
        else if sender.tag >= 200&&sender.tag < 300{
            popoverViewController.point  = mapSportPoints[sender.tag - 200]
        }
        else if sender.tag >= 300&&sender.tag < 400{
            popoverViewController.point  = mapMeetingPoints[sender.tag - 300]
        }
        else if sender.tag >= 400&&sender.tag < 500{
            popoverViewController.point  = mapLecturesPoints[sender.tag - 400]
        }
        
        popoverViewController.delegate = self
        
        if let popoverPresentationController = popoverViewController.popoverPresentationController{
            popoverPresentationController.delegate = self
            popoverPresentationController.sourceView = sender
            popoverPresentationController.sourceRect = sender.bounds
            popoverPresentationController.permittedArrowDirections = [.down]
            popoverPresentationController.backgroundColor = popoverViewController.view.backgroundColor
            present(popoverViewController, animated: true, completion: nil)
        }
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        menuView.frame = view.bounds
        menuView.frame.origin.y = -view.bounds.height
        menuMapView.frame.size.width = 100
        menuMapView.frame.origin.x = view.bounds.width - 100 
        menuMapView.frame.size.height = view.bounds.height
        menuMapView.frame.origin.y = -view.bounds.height

        menuMapView.layoutIfNeeded()
    }
    
    @IBAction func mapButtonPressed(_ sender: Any) {
        let barButtonItem = sender as! UIBarButtonItem
        if barButtonItem.image == UIImage(named:"exit"){
            barButtonItem.image = UIImage(named:"map")
        }
        else {barButtonItem.image = UIImage(named:"exit")}
        animate(sender: menuMapView)

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "questDescriptionsSegue"{
            let destinaton = segue.destination as! QuestDescriptionViewController
            destinaton.quest = questArray[questTag]
        }
    }
    
}
extension ViewController:Routable, MenuViewDelegate, PopoverViewControllerDelegate, MenuMapViewDelegate{
    func didSelectMenuMapButton(withTag tag: Int) {
        print(tag)
        switch tag {
        case 0:
            for view in self.imageView.subviews{
                if view.tag >= 100&&view.tag < 200{
                    if view.isHidden == true{
                        view.isHidden = false
                    }
                    else{
                        view.isHidden = true
                    }
                }
            }
        case 1:
            for view in self.imageView.subviews{
                if view.tag >= 300&&view.tag < 400{
                    if view.isHidden == true{
                        view.isHidden = false
                    }
                    else{
                        view.isHidden = true
                    }
                }
            }
        case 2:
            for view in self.imageView.subviews{
                if view.tag >= 400&&view.tag < 500{
                    if view.isHidden == true{
                        view.isHidden = false
                    }
                    else{
                        view.isHidden = true
                    }
                }
            }
        
        case 3:
            for view in self.imageView.subviews{
                if view.tag >= 200&&view.tag < 300{
                    if view.isHidden == true{
                        view.isHidden = false
                    }
                    else{
                        view.isHidden = true
                    }
                }
            }
        case 4:
            for view in self.imageView.subviews{
                if view.tag < 18{
                    if view.isHidden == true{
                        view.isHidden = false
                    }
                    else{
                        view.isHidden = true
                    }
                }
            }
     
        default:
            print(0)
        }
    }
    

    func didSelectPointButton() {
        performSegue(withIdentifier: "questDescriptionsSegue", sender: self)
    }
    
    //Здесь в зависимости от нажатой кнопки из дропдаун меню происходит переход по тегу соотвественно
    
    func didSelectButton(withTag: Int) {
        switch withTag {
        case 0:
            animate(sender: self.menuView)
        case 1:
            show(storyboard: StoryboardIdentifier.main, identifier: ViewControllerIdentifier.facultyView, configure: nil)
        case 2:
            show(storyboard: StoryboardIdentifier.main, identifier: ViewControllerIdentifier.orgView, configure: nil)
        case 3:
            show(storyboard: StoryboardIdentifier.main, identifier: ViewControllerIdentifier.hseView, configure: nil)
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
    
    func getDataFromJson(){
        let questUrl = Bundle.main.url(forResource: "questRus", withExtension:"json", subdirectory: "JsonData")
        //        let url = URL(fileURLWithPath: path!)
        
        var data = try! Data(contentsOf: questUrl!)
        
        var obj = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [[String : AnyObject]]
        for object in obj{
            let number = object["number"] as! String
            let name = object["name"] as! String
            let description = object["description"] as! String
            let passcode = object["passcode"] as! String
            let passed = object["passed"] as! Bool
            let x = object["x"] as! String
            let y = object["y"] as! String

            let newQuest = Quest(number: number, name: name, description: description, passcode: passcode, passed: passed, x: x, y: y)
            questArray.append(newQuest)
        }
        
        let sportUrl = Bundle.main.url(forResource: "entartainment", withExtension:"json", subdirectory: "JsonData")
        
        data = try! Data(contentsOf: sportUrl!)
        
        obj = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [[String : AnyObject]]
        for object in obj{
            let name = object["name"] as! String

            let x = object["x"] as! Int
            let y = object["y"] as! Int
            
            let newMapPont = MapPoint(name: name, x: x, y: y)
            mapSportPoints.append(newMapPont)
        }
        
        let entUrl = Bundle.main.url(forResource: "sport", withExtension:"json", subdirectory: "JsonData")
        
        data = try! Data(contentsOf: entUrl!)
        
        obj = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [[String : AnyObject]]
        for object in obj{
            let name = object["name"] as! String
            
            let x = object["x"] as! Int
            let y = object["y"] as! Int
            
            let newMapPont = MapPoint(name: name, x: x, y: y)
            mapEntPoints.append(newMapPont)
        }
        
        let meetingUrl = Bundle.main.url(forResource: "meeting", withExtension:"json", subdirectory: "JsonData")
        
        data = try! Data(contentsOf: meetingUrl!)
        
        obj = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [[String : AnyObject]]
        for object in obj{
            let name = object["name"] as! String
            
            let x = object["x"] as! Int
            let y = object["y"] as! Int
            
            let newMapPont = MapPoint(name: name, x: x, y: y)
            mapMeetingPoints.append(newMapPont)
        }
        
        let lecturesUrl = Bundle.main.url(forResource: "lectures", withExtension:"json", subdirectory: "JsonData")
        
        data = try! Data(contentsOf: lecturesUrl!)
        
        obj = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [[String : AnyObject]]
        for object in obj{
            let name = object["name"] as! String
            
            let x = object["x"] as! Int
            let y = object["y"] as! Int
            
            let newMapPont = MapPoint(name: name, x: x, y: y)
            mapLecturesPoints.append(newMapPont)
        }
    }
    
}

