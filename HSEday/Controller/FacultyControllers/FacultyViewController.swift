//
//  facultyViewController.swift
//  HSEday
//
//  Created by Anton Danilov on 17.08.2018.
//  Copyright © 2018 Anton Danilov. All rights reserved.
//

import UIKit


class FacultyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var menuView : MenuView!
    var facultyArray = [Faculty]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "Helvetica-Light", size: 20)!]

        tableView.rowHeight = 60
        
        setNavigationItem()
        getDataFromJson()
        
        menuView = Bundle.main.loadNibNamed("MenuView", owner: MenuView.self() , options: nil)?.first as! MenuView
        menuView.delegate = self
        self.view.addSubview(menuView)
        

    }
   

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        menuView.frame = view.bounds
        menuView.frame.origin.y = -view.bounds.height
        
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinaton = segue.destination as! FacultyDetailsViewController
        let index = tableView.indexPathForSelectedRow?.row
        destinaton.faculty = facultyArray[index!]
    }
    
    // MARK: TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return facultyArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FacultyTableViewCell
        cell.facultyLabel.text = facultyArray[indexPath.row].name
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "segue", sender: indexPath)
    }
}

extension FacultyViewController:Routable, MenuViewDelegate{
    func didSelectButton(withTag: Int) {
        
        if withTag != 1{
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
        animate(sender: self.menuView)
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
        let url = Bundle.main.url(forResource: "faculties", withExtension:"json", subdirectory: "JsonData")
//        let url = URL(fileURLWithPath: path!)
        
        let data = try! Data(contentsOf: url!)
        
        let obj = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [[String : AnyObject]]
        for object in obj{
            let name = object["name"] as! String
            let description = object["description"] as! String
            let departments = object["departments"] as! String
            let link = object["link"] as! String
            let imageUrl = object["imageUrl"] as! String
            let newFaculty = Faculty(name: name, description: description, departments: departments, link: link, imageUrl: imageUrl)
            facultyArray.append(newFaculty)
        }
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.hidesBarsOnSwipe = false
    }
}


