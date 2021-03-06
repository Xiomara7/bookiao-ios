//
//  AppointmentsViewController.swift
//  bookiao-ios
//
//  Created by Xiomara on 10/2/14.
//  Copyright (c) 2014 UPRRP. All rights reserved.
//

import UIKit
import CoreData

extension String {
    func toDate() -> NSDate? {
        var formatter:NSDateFormatter = NSDateFormatter()

        formatter.locale     = NSLocale(localeIdentifier: "en_US_POSIX")
        formatter.timeZone   = NSTimeZone()
        formatter.dateStyle  = .MediumStyle
        formatter.dateFormat = "EEEE-MM-dd"
        
        return formatter.dateFromString(self)
    }
}

extension NSDate {
    func toS() -> String? {
        var formatter:NSDateFormatter = NSDateFormatter()
        
        formatter.locale     = NSLocale(localeIdentifier: "en_US_POSIX")
        formatter.timeZone   = NSTimeZone()
        formatter.dateStyle  = .MediumStyle
        formatter.dateFormat = "yyyy-MM-dd"
        
        return formatter.stringFromDate(self)
    }
}

class HistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var names: NSArray! = []
    var tableView: UITableView!
    var dataSource: [[String: String]] = []
    var customDesign = CustomDesign()
    var requests = HTTPrequests()
    var refreshControl:UIRefreshControl!
    
    let application = UIApplication.sharedApplication().delegate as AppDelegate
    
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

        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refersh")
        self.refreshControl.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)
    
    }
    
    func refresh() {
        println("Refreshing")
    }
    
    // MARK: - Private Methods
    
    func updateDataSource() {
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
        let ut = DataManager.sharedManager.userInfo["userType"] as String!
        if ut == "employee" {
            return DataManager.sharedManager.employeeAppointments.count
        }
        if ut == "client" {
            return DataManager.sharedManager.clientAppointments.count
        }
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let CellIdentifier = "Cell"
        
        let ut = DataManager.sharedManager.userInfo["userType"] as String!
        let eAppointments = DataManager.sharedManager.employeeAppointments
        let cAppointments = DataManager.sharedManager.clientAppointments
        
        var cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier) as CustomCellHistory!
        if  cell == nil {
            cell = CustomCellHistory(reuseIdentifier: "Cell")
        }
        
        let cellFrame = CGRectMake(0.0, 0.0, 320.0, 200.0)
        
        if ut == "employee" {
            if DataManager.sharedManager.employeeAppointments.count != 0 {
                let day  = eAppointments[indexPath.row]["day"]  as String!
                let time = eAppointments[indexPath.row]["time"] as String!
        
                cell.titleLabel.text    = eAppointments[indexPath.row]["client"] as String!
                cell.subtitleLabel.text = "En \(day) a las \(time)"
            }
        }
        if ut == "client" {
            if cAppointments.count != 0 {
                let day  = cAppointments[indexPath.row]["day"]  as String!
                let time = cAppointments[indexPath.row]["time"] as String!
            
                cell.titleLabel.text = cAppointments[indexPath.row]["employee"] as String!
                cell.subtitleLabel.text = "En \(day) a las \(time)"
            }
        }
        if ut == "business" {
            cell.titleLabel.text    = ""
            cell.subtitleLabel.text = ""
        }

        cell.setNeedsUpdateConstraints()
        cell.selectionStyle = .Default
        cell.accessoryType  = .None
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 95.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("Hello")
    }
    
}
