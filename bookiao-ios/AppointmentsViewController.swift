//
//  AppointmentsViewController.swift
//  bookiao-ios
//
//  Created by Xiomara on 10/2/14.
//  Copyright (c) 2014 UPRRP. All rights reserved.
//

import UIKit
import CoreData

class AppointmentsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let application = UIApplication.sharedApplication().delegate as AppDelegate
    
    var tableView: UITableView!
    var dataSource: [[String: String]] = []
    var names: NSArray! = []
    var customDesign = CustomDesign()
    
    override func viewDidLoad() {
    
        self.view = UIView(frame: self.view.bounds)
        self.view.backgroundColor = UIColor.whiteColor()
        let tableAppearance = UITableView.appearance()
        
        tableView = UITableView(frame: CGRectMake(0, -40, self.view.frame.width, self.view.frame.height), style: .Grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tintColor = UIColor.whiteColor()
        tableView.showsVerticalScrollIndicator = true
        tableView.separatorColor = UIColor.grayColor()
        tableView.backgroundColor = customDesign.UIColorFromRGB(0xE4E4E4)
        self.view.backgroundColor = customDesign.UIColorFromRGB(0xE4E4E4)
        self.view.addSubview(tableView)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.navigationItem.title = "Citas"
        self.tabBarController?.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.tabBarItem.setTitlePositionAdjustment(UIOffsetMake(0, -50))
    }
    
    // MARK: - Private Methods
    
    func updateDataSource() {
        var rows = [[String: String]]()
        
        for index in 0..<5 {
            var sum = (index + 1) * 5 * 6
            rows.append(["text": "", "detail": "La cita comienza en \(sum) minutos"])
        }
        
        dataSource = rows
        tableView.reloadData()
    }
    
    // MARK: - UITableViewDataSource Methods
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.application.userInfo["userType"] as String! == "employee" {
            return self.application.employeeAppointmentsPerDay.count
        }
        if self.application.userInfo["userType"] as String! == "client" {
            return self.application.clientAppointmentsPerDay.count
        }
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let CellIdentifier = "Cell"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier) as CustomCell!
        if  cell == nil {
            cell = CustomCell(reuseIdentifier: "Cell")
        }
        
        let cellFrame = self.view.bounds
        if self.application.userInfo["userType"] as String! == "employee" {
            
            let day  = self.application.employeeAppointmentsPerDay[indexPath.row]["day"] as String!
            let time = self.application.employeeAppointmentsPerDay[indexPath.row]["time"] as String!
            let services = self.application.employeeAppointmentsPerDay[indexPath.row]["services"] as NSArray!
            
            cell.titleLabel.text = self.application.employeeAppointmentsPerDay[indexPath.row]["client"] as String!
            cell.subtitleLabel.text = "La cita comienza a las \(time)"
            cell.priceLabel.text = services[0] as? String
        }
        if self.application.userInfo["userType"] as String! == "client" {
            let day  = self.application.clientAppointmentsPerDay[indexPath.row]["day"] as String!
            let time = self.application.clientAppointmentsPerDay[indexPath.row]["time"] as String!
            let services = self.application.clientAppointmentsPerDay[indexPath.row]["services"] as NSArray!
            
            cell.titleLabel.text = self.application.clientAppointmentsPerDay[indexPath.row]["employee"] as String!
            cell.subtitleLabel.text = "La cita comienza a las \(time)"
            cell.priceLabel.text = services[0] as? String
        }
        if self.application.userInfo["userType"] as String! == "business" {
            cell.titleLabel.text = ""
            cell.subtitleLabel.text = ""
        }
        cell.textLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        cell.textLabel.font = UIFont.systemFontOfSize(20.0)
        cell.textLabel.numberOfLines = 0
        
        cell.selectionStyle = .Default
        cell.accessoryType = .None
        
        cell.frame.origin.y = 4
        cell.setNeedsUpdateConstraints()
        
        return cell
    }
    
    // MARK: UITableViewDelegate Methods
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 95.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("Hello")
    }
    
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem!){
        println(item)
    }
    
    
}
