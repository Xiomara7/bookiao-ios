//
//  AppointmentsViewController.swift
//  bookiao-ios
//
//  Created by Xiomara on 10/2/14.
//  Copyright (c) 2014 UPRRP. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tableView: UITableView!
    var headerView: UIView!
    var dataSource: [[String: String]] = []
    var customDesign = CustomDesign()
    
    var names = ["Nombre", "Posición", "Trabajo", "Horas de trabajo", "Lugar"]
    var info  = ["Christian Rodríguez", "Barbero", "Tony's Barber", "5:00 pm"]
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!){
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func loadView() {
        self.view = UIView(frame: CGRectMake(0.0, 0.0, 380.0, 500.0))
        self.view.backgroundColor = UIColor.whiteColor()
        
        tableView = UITableView(frame: self.view.bounds, style: .Grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tintColor = UIColor.whiteColor()
        tableView.backgroundColor = customDesign.UIColorFromRGB(0x93D946)
        
        self.view.addSubview(tableView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateDataSource()
    }
    
    // MARK: - Private Methods

    
    func updateDataSource() {
        var rows = [[String: String]]()
        
        for index in 0..<4 {
            var sum = (index + 1) * 5 * 6
            rows.append(["text": names[index], "detail": info[index]])
        }
        
        dataSource = rows
        tableView.reloadData()
    }
    
    // MARK: - UITableViewDataSource Methods
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }
        else {
            return 4
        }
    }
    

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let CellIdentifier = "Cell"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier) as UITableViewCell!
        if cell == nil {
            
            cell = UITableViewCell(style: .Subtitle, reuseIdentifier:CellIdentifier)
        }
        
        let dictionary = dataSource[indexPath.row]
        
        let cellFrame = CGRectMake(100.0, 100.0, 320.0, 200.0)
        if indexPath.section == 1 {
            cell.frame = cellFrame
            cell.textLabel!.numberOfLines = 0
            cell.textLabel?.text = dictionary["text"]
            cell.detailTextLabel?.text = dictionary["detail"]
        
            cell.textLabel!.setTranslatesAutoresizingMaskIntoConstraints(false)
            cell.textLabel!.font = UIFont.systemFontOfSize(12.0)
            cell.textLabel!.numberOfLines = 0
        }
        else if indexPath.section == 0 {
            cell.backgroundColor = UIColor.grayColor()
        }
        return cell
    }
    
//    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        if section == 0 {
//            self.headerView = UIView(frame: CGRectMake(0.0, 0.0, 380.0, 500.0))
//            self.headerView.backgroundColor = UIColor.grayColor()
//        }
//        else if section == 1 {
//            self.headerView = UIView(frame: CGRectMake(0.0, 0.0, 0.0, 0.0))
//            self.headerView.backgroundColor = UIColor.grayColor()
//        }
//        
//        return self.headerView
//        
//    }
    
    
    // MARK: UITableViewDelegate Methods
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 100.0
        }
        else {
            return 80.0
        }
    }
    
}
