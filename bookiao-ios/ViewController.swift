//
//  ViewController.swift
//  bookiao-ios
//
//  Created by Xiomara on 9/30/14.
//  Copyright (c) 2014 UPRRP. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class ViewController: UIViewController {

    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!){
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        

    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let customDesign = CustomDesign()
        let appointments = AppointmentsViewController(nibName: nil, bundle: nil)
        let history = HistoryViewController(nibName: nil, bundle: nil)
        let profile = ProfileViewController(nibName: nil, bundle: nil)
        let citasTextLabel    = UITabBarItem(title: "", image: UIImage(named: "booking.png"), tag: 0)
        let historyTextLabel  = UITabBarItem(title: "", image: UIImage(named: "history.png"), tag: 1)
        let settingsTextLabel = UITabBarItem(title: "", image: UIImage(named: "profile.png"), tag: 2)
        
        appointments.tabBarItem = citasTextLabel
        history.tabBarItem = historyTextLabel
        profile.tabBarItem = settingsTextLabel
        
        appointments.tabBarItem.setTitlePositionAdjustment(UIOffsetMake(0, 0))
        history.tabBarItem.setTitlePositionAdjustment(UIOffsetMake(0, 0))
        profile.tabBarItem.setTitlePositionAdjustment(UIOffsetMake(0, 0))
        
        let controllers = [appointments, history, profile]
        
        let tabBar = UITabBarController()
        var tabBarAppearance = UITabBar.appearance()
        tabBarAppearance.backgroundColor = customDesign.UIColorFromRGB(0x323C3E)
        tabBarAppearance.tintColor = customDesign.UIColorFromRGB(0x00B287)
        tabBar.viewControllers = controllers
    
        let button = UIBarButtonItem(image: UIImage(named: "post.png"), style: UIBarButtonItemStyle.Plain, target: self, action: Selector("tapPost"))
        let navBar = UINavigationController(rootViewController: tabBar)
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.backgroundColor = customDesign.UIColorFromRGB(0x323C3E)
        navBar.tabBarController?.tabBar.backgroundColor = customDesign.UIColorFromRGB(0x323C3E)
        navBar.navigationBar.backgroundColor = UIColor.blackColor()
        navBar.navigationItem.rightBarButtonItem = button
        
        let application = UIApplication.sharedApplication().delegate as AppDelegate
        application.window.rootViewController = navBar
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem!){
        println(item)
    }

}
