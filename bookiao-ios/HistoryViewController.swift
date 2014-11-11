//
//  AppointmentsViewController.swift
//  bookiao-ios
//
//  Created by Xiomara on 10/2/14.
//  Copyright (c) 2014 UPRRP. All rights reserved.
//

import UIKit
import CoreData

class HistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tableView: UITableView!
    var dataSource: [[String: String]] = []
    var names: NSArray! = []
    var customDesign = CustomDesign()
    
    let application = UIApplication.sharedApplication().delegate as AppDelegate
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!){
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
    
        self.view = UIView(frame: self.view.bounds)
        self.view.backgroundColor = UIColor.whiteColor()
        
        tableView = UITableView(frame: CGRectMake(0, 20, self.view.frame.width, self.view.frame.height), style: .Grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = customDesign.UIColorFromRGB(0xE4E4E4)
        tableView.headerViewForSection(0)?.tintColor = UIColor.whiteColor()
        self.view.backgroundColor = customDesign.UIColorFromRGB(0xE4E4E4)
        self.view.addSubview(tableView)
    }
    
    // MARK: - Private Methods
    
    func updateDataSource() {
        var rows = [[String: String]]()
        for index in 0..<5 {
            var sum = (index + 1) * 5 * 6
            rows.append(["text": "", "detail": "Hace \(sum) minutos"])
        }
        
        dataSource = rows
        tableView.reloadData()
    }
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.navigationItem.title = "Historial"
        self.tabBarController?.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.tabBarController?.navigationController?.navigationBar.backgroundColor = UIColor.whiteColor()
    }
    
    // MARK: - UITableViewDataSource Methods
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.application.userInfo["userType"] as String! == "employee" {
            return self.application.employeeAppointments.count
        }
        if self.application.userInfo["userType"] as String! == "client" {
            return self.application.clientAppointments.count
        }
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let CellIdentifier = "Cell"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier) as CustomCellHistory!
        if  cell == nil {
            cell = CustomCellHistory(reuseIdentifier: "Cell")
        }
        
        let cellFrame = CGRectMake(0.0, 0.0, 320.0, 200.0)
        let check = UIImage(named: "check.png")
        
        if self.application.userInfo["userType"] as String! == "employee" {
            let day  = self.application.employeeAppointments[indexPath.row]["day"] as String!
            let time = self.application.employeeAppointments[indexPath.row]["time"] as String!
            
            cell.titleLabel.text = self.application.employeeAppointments[indexPath.row]["client"] as String!
            cell.subtitleLabel.text = "El \(day) a las \(time)"
        }
        if self.application.userInfo["userType"] as String! == "client" {
            let day  = self.application.clientAppointments[indexPath.row]["day"] as String!
            let time = self.application.clientAppointments[indexPath.row]["time"] as String!
            
            cell.titleLabel.text = self.application.clientAppointments[indexPath.row]["employee"] as String!
            cell.subtitleLabel.text = "El \(day) a las \(time)"
        }
        if self.application.userInfo["userType"] as String! == "business" {
            cell.titleLabel.text = ""
            cell.subtitleLabel.text = ""
        }
        
        cell.textLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        cell.textLabel.font = UIFont.systemFontOfSize(20.0)
        cell.textLabel.numberOfLines = 0
        cell.selectionStyle = .Default
        cell.accessoryType  = .None
        cell.setNeedsUpdateConstraints()
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 95.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("Hello")
    }
    
}
