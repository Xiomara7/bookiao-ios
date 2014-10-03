//
//  AppointmentsViewController.swift
//  bookiao-ios
//
//  Created by Xiomara on 10/2/14.
//  Copyright (c) 2014 UPRRP. All rights reserved.
//

import UIKit

class AppointmentsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tableView: UITableView!
    
    var dataSource: [[String: String]] = []
    
    var names = ["Christian Rodríguez", "Alex Santos", "Xiomara Figueroa", "Ramphis Castro", "Abimael Carrasquillo"]
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!){
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func loadView() {
        self.view = UIView(frame: CGRectMake(0.0, 0.0, 380.0, 480.0))
        self.view.backgroundColor = UIColor.whiteColor()
        
        tableView = UITableView(frame: self.view.bounds, style: .Grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor.greenColor()
        tableView.tintColor = UIColor.whiteColor()
        
        self.view.addSubview(tableView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateDataSource()
    }
    
    // MARK: - Private Methods
    
    func updateDataSource() {
        var rows = [[String: String]]()
        
        for index in 0..<5 {
            rows.append(["text": names[index], "detail": "$ \(index + 5)"])
        }
        
        dataSource = rows
        tableView.reloadData()
    }
    
    // MARK: - UITableViewDataSource Methods
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let CellIdentifier = "Cell"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier) as UITableViewCell!
        if cell == nil {
            cell = UITableViewCell(style: .Value1, reuseIdentifier:CellIdentifier)
        }
        
        let dictionary = dataSource[indexPath.row]
        
        let cellFrame = CGRectMake(0.0, 0.0, 320.0, 200.0)
        
        cell.frame = cellFrame
        cell.textLabel!.numberOfLines = 0
        cell.textLabel?.text = dictionary["text"]
        cell.detailTextLabel?.text = dictionary["detail"]
        
        cell.textLabel!.setTranslatesAutoresizingMaskIntoConstraints(false)
        cell.textLabel!.font = UIFont.systemFontOfSize(20.0)
        cell.textLabel!.numberOfLines = 0
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Citas"
    }
    
    func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "The footer is aligned to the left"
    }
    
    // MARK: UITableViewDelegate Methods
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100.0
    }
    
}
