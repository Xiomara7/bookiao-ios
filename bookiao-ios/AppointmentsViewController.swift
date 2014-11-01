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
    
    override func loadView() {
        self.view = UIView(frame: CGRectMake(0.0, 0.0, 330.0, 530.0))
        self.view.backgroundColor = UIColor.whiteColor()
        let tableAppearance = UITableView.appearance()
        let postButton = UIBarButtonItem(image: UIImage(named: "post"), style: UIBarButtonItemStyle.Plain, target: self, action: Selector("didTapConnect"))
        
        tableView = UITableView(frame: self.view.bounds, style: .Grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = customDesign.UIColorFromRGB(0x00B287)
        tableView.tintColor = UIColor.whiteColor()
        tableView.showsVerticalScrollIndicator = true
        tableView.separatorColor = UIColor.grayColor()
        tableView.headerViewForSection(0)?.tintColor = .whiteColor()
        
        self.navigationController?.navigationItem.rightBarButtonItem = postButton
        self.view.backgroundColor = customDesign.UIColorFromRGB(0xE4E4E4)
        
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
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let CellIdentifier = "Cell"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier) as CustomCell!
        if cell == nil {
            cell = CustomCell(reuseIdentifier: "Cell")
        }
        
        let dictionary = dataSource[indexPath.row]
        
        let cellFrame = CGRectMake(0.0, 0.0, 320.0, 200.0)
        
        cell.priceLabel.text = self.prices[indexPath.row]
        cell.titleLabel.text = self.names[indexPath.row]
        cell.subtitleLabel.text = dictionary["detail"]
        
        cell.textLabel!.setTranslatesAutoresizingMaskIntoConstraints(false)
        cell.textLabel!.font = UIFont.systemFontOfSize(20.0)
        cell.textLabel!.numberOfLines = 0
        
        cell.selectionStyle = .Default
        cell.accessoryType = .None
        
        
        cell.frame.origin.y = 4
        
        cell.setNeedsUpdateConstraints()
        
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Hogar"
    }

    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0
    }
    
    // MARK: UITableViewDelegate Methods
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 95.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("Hello")
    }
    
    
    
}
