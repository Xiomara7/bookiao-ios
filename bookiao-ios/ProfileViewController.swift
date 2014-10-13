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
    
    var info = ["Nombre", "Posición", "Trabajo", "Horas de trabajo", "Lugar"]
    var fields  = ["Christian Rodríguez", "Barbero", "DMC", "8:00 am - 5:00 pm"]
    
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
        tableView.tableHeaderView?.backgroundColor = customDesign.UIColorFromRGB(0x343333)
        
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
            rows.append(["text": info[index], "detail": fields[index]])
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
        
        var cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier) as CustomCellProfile!
        if cell == nil {
            
            cell = CustomCellProfile(reuseIdentifier: "Cell")
        }
        
        let dictionary = dataSource[indexPath.row]
        
        //let cellFrame = CGRectMake(100.0, 100.0, 320.0, 200.0)
        if indexPath.section == 1 {
            cell.titleLabel.text = self.info[indexPath.row]
            cell.infoField.placeholder = self.fields[indexPath.row]
            
            
            cell.textLabel!.setTranslatesAutoresizingMaskIntoConstraints(false)
            cell.textLabel!.font = UIFont.systemFontOfSize(20.0)
            cell.textLabel!.numberOfLines = 0
            
            cell.selectionStyle = .Default
            cell.accessoryType = .None
            
            cell.setNeedsUpdateConstraints()
        }
        else if indexPath.section == 0 {
            cell.backgroundColor = customDesign.UIColorFromRGB(0x343333)
        }
        
        cell.textLabel!.setTranslatesAutoresizingMaskIntoConstraints(false)
        cell.textLabel!.font = UIFont.systemFontOfSize(20.0)
        cell.textLabel!.numberOfLines = 0
        
        cell.selectionStyle = .Default
        cell.accessoryType = .None
        
        cell.setNeedsUpdateConstraints()
        
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
            return 170.0
        }
        else {
            return 65.0
        }
    }
    
}
