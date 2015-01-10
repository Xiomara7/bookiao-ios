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
    
    var names: NSArray! = []
    var tableView: UITableView!
    var dataSource: [[String: String]] = []
    var refreshControl:UIRefreshControl!
    
    var customDesign = CustomDesign()
    var requests = HTTPrequests()
    
    override func viewDidLoad() {
    
        self.view = UIView(frame: self.view.bounds)
        self.view.backgroundColor = UIColor.whiteColor()
        let tableAppearance = UITableView.appearance()
        
        tableView = UITableView(frame: CGRectMake(0, -40, self.view.frame.width, self.view.frame.height), style: .Grouped)
        tableView.delegate   = self
        tableView.dataSource = self
        tableView.tintColor  = UIColor.whiteColor()
        tableView.separatorColor  = UIColor.grayColor()
        tableView.backgroundColor = customDesign.UIColorFromRGB(0xE4E4E4)
        tableView.showsVerticalScrollIndicator = true
        self.view.addSubview(tableView)
        self.tabBarController?.navigationItem.title = DataManager.sharedManager.dateLabel
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refersh")
        self.refreshControl.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)
        
    }
    
    func refresh() {
//        let ut = DataManager.sharedManager.userInfo["userType"] as String
//        let id = DataManager.sharedManager.userInfo["id"] as Int
//        
//        if ut == "client" {
//            self.requests.getClientAppointments(id)
//            self.requests.getClientAppointmentsPerDay(id, date: DataManager.sharedManager.date)
//        }
//        if ut == "employee" {
//            self.requests.getEmployeeAppointments(id)
//            self.requests.getEmployeeAppointmentsPerDay(id, date: DataManager.sharedManager.date)
//        }
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.navigationItem.title = DataManager.sharedManager.dateLabel
        self.tabBarController?.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.tabBarItem.setTitlePositionAdjustment(UIOffsetMake(0, -50))
    }
    
    // MARK: - Private Methods
    
    func updateDataSource() {
        tableView.reloadData()
    }
    
    // MARK: - UITableViewDataSource Methods
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let ut = DataManager.sharedManager.userInfo["userType"] as String!
        let eAppointments = DataManager.sharedManager.employeeAppointmentsPerDay
        let cAppointments = DataManager.sharedManager.clientAppointmentsPerDay
        
        if eAppointments.count == 0 {
            return 1
        }
        if cAppointments.count == 0 {
            return 1
        }
        if ut == "employee" {
            return eAppointments.count
        }
        if ut == "client" {
            return cAppointments.count
        }
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let CellIdentifier = "Cell"
        
        let ut = DataManager.sharedManager.userInfo["userType"] as String!
        let eAppointments = DataManager.sharedManager.employeeAppointmentsPerDay as NSArray!
        let cAppointments = DataManager.sharedManager.clientAppointmentsPerDay as NSArray!
        
        var cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier) as CustomCell!
        if  cell == nil {
            cell = CustomCell(reuseIdentifier: "Cell")
        }
        
        let cellFrame = self.view.bounds
        if ut == "employee" {
            if eAppointments.count == 0 && cAppointments.count == 0 {
                cell.sTitle.text = DataManager.sharedManager.Title
                cell.status.text = DataManager.sharedManager.status
            }
            else {
                let day  = eAppointments[indexPath.row]["day"] as String!
                let time = eAppointments[indexPath.row]["time"] as String!
                let serv = eAppointments[indexPath.row]["services"] as NSArray!
            
                cell.priceLabel.text  = serv[0] as? String
                cell.titleLabel.text  = eAppointments[indexPath.row]["client"] as String!
                cell.phoneLabel.text  = DataManager.sharedManager.userInfo["phone_number"] as String!
                cell.stitleLabel.text = "\(DataManager.sharedManager.phrase) \(time)"
            }
        }
        else if ut! == "client" {
            if cAppointments.count == 0 && eAppointments.count == 0 {
                cell.sTitle.text = DataManager.sharedManager.Title
                cell.status.text = DataManager.sharedManager.status
                
            }
            else {
                let day  = cAppointments[indexPath.row]["day"] as String!
                let time = cAppointments[indexPath.row]["time"] as String!
                let serv = cAppointments[indexPath.row]["services"] as NSArray!
            
                cell.priceLabel.text  = serv[0] as? String
                cell.titleLabel.text  = cAppointments[indexPath.row]["employee"] as String!
                cell.phoneLabel.text  = DataManager.sharedManager.userInfo["phone_number"] as String!
                cell.stitleLabel.text = "\(DataManager.sharedManager.phrase) \(time)"
            }
        }
        
        cell.selectionStyle = .Default
        cell.accessoryType  = .None
        cell.frame.origin.y = 4
        cell.setNeedsUpdateConstraints()
        
        return cell
    }
    
    // MARK: UITableViewDelegate Methods
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 140.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("Hello")
    }
    
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem!){
        println(item)
    }
    
    func post() {
        let newPost = newAppointmentViewController()
        self.presentViewController(newPost, animated: true, completion: nil)
    }
    
    
}
