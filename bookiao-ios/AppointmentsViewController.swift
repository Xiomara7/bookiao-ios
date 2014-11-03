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

    var tableView: UITableView!
    var dataSource: [[String: String]] = []
    var names = ["Alex Santos", "Christian Rodríguez", "Xiomara Figueroa", "Ramphis Castro", "Abimael Carrasquillo"]
    var prices = ["$14", "$8", "$22", "$12", "$10"]
    var customDesign = CustomDesign()

    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!){
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
    
        self.view = UIView(frame: CGRectMake(0.0, 0.0, 330.0, 530.0))
        self.view.backgroundColor = UIColor.whiteColor()
        let tableAppearance = UITableView.appearance()
        
        tableView = UITableView(frame: self.view.bounds, style: .Grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tintColor = UIColor.whiteColor()
        tableView.showsVerticalScrollIndicator = true
        tableView.separatorColor = UIColor.grayColor()
        
        self.view.backgroundColor = customDesign.UIColorFromRGB(0xE4E4E4)
        
        self.view.addSubview(tableView)
        
    }
    
    // MARK: - Private Methods
    
    func updateDataSource() {
        var rows = [[String: String]]()
        
        for index in 0..<5 {
            var sum = (index + 1) * 5 * 6
            rows.append(["text": names[index], "detail": "La cita comienza en \(sum) minutos"])
        }
        
        dataSource = rows
        tableView.reloadData()
    }
    
    // MARK: - UITableViewDataSource Methods
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let CellIdentifier = "Cell"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier) as CustomCell!
        if cell == nil {
            cell = CustomCell(reuseIdentifier: "Cell")
        }
        
        let cellFrame = CGRectMake(0.0, 0.0, 320.0, 200.0)
        
        cell.priceLabel.text = self.prices[indexPath.row]
        cell.titleLabel.text = self.names[indexPath.row]
        
        cell.textLabel!.setTranslatesAutoresizingMaskIntoConstraints(false)
        cell.textLabel!.font = UIFont.systemFontOfSize(20.0)
        cell.textLabel!.numberOfLines = 0
        
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
