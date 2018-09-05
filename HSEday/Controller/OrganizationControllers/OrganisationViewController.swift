//
//  OrganisationViewController.swift
//  HSEday
//
//  Created by Anton Danilov on 20.08.2018.
//  Copyright © 2018 Anton Danilov. All rights reserved.
//

import UIKit

struct cellData {
    var opened = Bool()
    var orgInSection = [Organization]()
    var title = String()
}

class OrganisationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var menuView : MenuView!
    var orgArray = [String : [Organization]]()
    var tableViewData = [cellData]()

    @IBOutlet weak var orgTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "Helvetica-Light", size: 20)!]
        getDataFromJson()
        setNavigationItem()
        addDataToCellArray()
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        self.orgTableView.rowHeight = 60
        
        menuView = Bundle.main.loadNibNamed("MenuView", owner: MenuView.self() , options: nil)?.first as! MenuView
        self.view.addSubview(menuView)
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        
        menuView.frame = view.bounds
        menuView.frame.origin.y = -view.bounds.height
        menuView.delegate = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewData.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableViewData[section].opened{
            return tableViewData[section].orgInSection.count + 1
        }
        else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = UITableViewCell(style: .default, reuseIdentifier: "topCell")
            cell.textLabel?.text = tableViewData[indexPath.section].title
            cell.textLabel?.font = UIFont(name: "Helvetica-Light", size: 17)
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "innerCell", for: indexPath) as! OrganizationTableViewCell
            cell.orgName.text = tableViewData[indexPath.section].orgInSection[indexPath.row - 1].name
            let imageName = tableViewData[indexPath.section].orgInSection[indexPath.row - 1].imageUrl
            cell.orgImage.image = UIImage(named: imageName)
            cell.orgName.font = UIFont(name: "Helvetica-Light", size: 17)
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            if tableViewData[indexPath.section].opened{
                tableViewData[indexPath.section].opened = false
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none)
            }
            else{
                tableViewData[indexPath.section].opened = true
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none)
            }
        }
        else{
            performSegue(withIdentifier: "showOrganizationDetailsSegue", sender: indexPath)
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinaton = segue.destination as! OrganizationDetailsViewController
        let index = orgTableView.indexPathForSelectedRow?.row
        let section = orgTableView.indexPathForSelectedRow?.section
        if index != 0{
            destinaton.org = tableViewData[section!].orgInSection[index!-1]
        }
        
    }
}
extension OrganisationViewController: Routable, MenuViewDelegate{
    func didSelectButton(withTag: Int) {
        switch withTag {
        case 0:
            show(storyboard: StoryboardIdentifier.main, identifier: ViewControllerIdentifier.mapView, configure: nil)
        case 1:
            show(storyboard: StoryboardIdentifier.main, identifier: ViewControllerIdentifier.facultyView, configure: nil)
        case 2:
            animate(sender: self.menuView)
        case 3:
            show(storyboard: StoryboardIdentifier.main, identifier: ViewControllerIdentifier.hseView, configure: nil)
        case 4:
            show(storyboard: StoryboardIdentifier.main, identifier: ViewControllerIdentifier.questView, configure: nil)
        default:
            show(storyboard: StoryboardIdentifier.main, identifier: ViewControllerIdentifier.mapView, configure: nil)
        }
    }
    func setNavigationItem(){
        let menuBarItem = UIBarButtonItem(image: UIImage(named: "MENU30"), style: .plain, target: self, action: #selector(menuButtonPressed))
        menuBarItem.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = menuBarItem
    }
    @IBAction func menuButtonPressed(_ sender: Any) {
        let barButtonItem = sender as! UIBarButtonItem
        if barButtonItem.image == UIImage(named:"CANCEL30"){
            barButtonItem.image = UIImage(named:"MENU30")
        }
        else {barButtonItem.image = UIImage(named:"CANCEL30")}
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
        let questUrl = Bundle.main.url(forResource: "organizations", withExtension:"json", subdirectory: "JsonData")
        //        let url = URL(fileURLWithPath: path!)
        
        let data = try! Data(contentsOf: questUrl!)
        
        let obj = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [[String : AnyObject]]
        for object in obj{
            let group = object["group"] as! String
            let name = object["name"] as! String
            let description = object["description"] as! String
            let link = object["contacts"] as! String
            let imageUrl = object["imageURL"] as! String
            
            

            
            let newOrg = Organization(group: group, name: name, description: description, link: link, imageUrl: imageUrl)
            switch newOrg.group{
            case "Театр и кино":
                if orgArray["Театр и кино"]?.count == nil{
                    orgArray["Театр и кино"] = []
                }
                orgArray["Театр и кино"]?.append(newOrg)
                
            case "Добрые проекты":
                if orgArray["Добрые проекты"]?.count == nil{
                    orgArray["Добрые проекты"] = []
                }
                orgArray["Добрые проекты"]?.append(newOrg)
                
            case "СМИ":
                if orgArray["СМИ"]?.count == nil{
                    orgArray["СМИ"] = []
                }
                orgArray["СМИ"]?.append(newOrg)
                
            case "Развлекательные":
                if orgArray["Развлекательные"]?.count == nil{
                    orgArray["Развлекательные"] = []
                }
                orgArray["Развлекательные"]?.append(newOrg)
                
            case "Музыка":
                if orgArray["Музыка"]?.count == nil{
                    orgArray["Музыка"] = []
                }
                orgArray["Музыка"]?.append(newOrg)
            case "Спортивные":
                if orgArray["Спортивные"]?.count == nil{
                    orgArray["Спортивные"] = []
                }
                orgArray["Спортивные"]?.append(newOrg)
                
            case "Бизнес и карьера":
                if orgArray["Бизнес и карьера"]?.count == nil{
                    orgArray["Бизнес и карьера"] = []
                }
                orgArray["Бизнес и карьера"]?.append(newOrg)
                
            case "Вышка без границ":
                if orgArray["Вышка без границ"]?.count == nil{
                    orgArray["Вышка без границ"] = []
                }
                orgArray["Вышка без границ"]?.append(newOrg)
            case "Просвещение":
                if orgArray["Просвещение"]?.count == nil{
                    orgArray["Просвещение"] = []
                }
                orgArray["Просвещение"]?.append(newOrg)
            default:
                print("wrong")
            }
        }
        print(orgArray["Театр и кино"]!.count)
    }
    func addDataToCellArray(){
        for (group, organization) in orgArray{
            let newCellData = cellData(opened: false, orgInSection: organization, title: group)
            tableViewData.append(newCellData)
        }
    }
}
