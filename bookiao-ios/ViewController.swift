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
    let request = HTTPrequests()
    let application = UIApplication.sharedApplication().delegate as AppDelegate
    
    let customDesign = CustomDesign()
    let appointments: UIViewController = AppointmentsViewController(nibName: nil, bundle: nil)
    let history: UIViewController = HistoryViewController(nibName: nil, bundle: nil)
    let profile: UIViewController = ProfileViewController(nibName: nil, bundle: nil)

    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!){
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let citasTextLabel    = UITabBarItem(title: "", image: UIImage(named: "booking.png"), tag: 0)
        let historyTextLabel  = UITabBarItem(title: "", image: UIImage(named: "history.png"), tag: 1)
        let settingsTextLabel = UITabBarItem(title: "", image: UIImage(named: "profile.png"), tag: 2)
        
        appointments.tabBarItem = citasTextLabel
        history.tabBarItem = historyTextLabel
        profile.tabBarItem = settingsTextLabel
        
        appointments.tabBarItem.setTitlePositionAdjustment(UIOffsetMake(0, -10))
        history.tabBarItem.setTitlePositionAdjustment(UIOffsetMake(0, -10))
        profile.tabBarItem.setTitlePositionAdjustment(UIOffsetMake(0, -10))
        
        let controllers = [appointments, history, profile]
        
        let tabBar = UITabBarController()
        var tabBarAppearance = UITabBar.appearance()
        tabBarAppearance.backgroundColor = customDesign.UIColorFromRGB(0x323C3E)
        tabBarAppearance.backgroundImage = UIImage(named: "back.png")
        tabBarAppearance.tintColor = customDesign.UIColorFromRGB(0x00B287)
        tabBar.viewControllers = controllers
        
        tabBarAppearance.translucent = false
    
        let navBar = UINavigationController(rootViewController: tabBar)
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.backgroundColor = customDesign.UIColorFromRGB(0x323C3E)
        navBar.tabBarController?.tabBar.backgroundColor = customDesign.UIColorFromRGB(0x323C3E)
        navBar.navigationBar.backgroundColor = customDesign.UIColorFromRGB(0x323C3E)
        navBar.navigationBar.setBackgroundImage(UIImage(named: "menubar.png"), forBarMetrics:.Default)
        let postButton = UIBarButtonItem(image: UIImage(named: "post.png"), style:.Plain, target: self, action: Selector("tapPost"))
        let calendarButton = UIBarButtonItem(image: UIImage(named: "calendar.png"), style: UIBarButtonItemStyle.Plain, target: self, action: Selector("tapPostCalendar"))

        tabBar.navigationItem.rightBarButtonItem = postButton
        tabBar.navigationItem.leftBarButtonItem = calendarButton
        
        let application = UIApplication.sharedApplication().delegate as AppDelegate
        application.window.rootViewController = navBar
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tapPostCalendar() {
        let calendarView = calendarViewController(nibName: nil, bundle: nil)
        self.application.window.rootViewController = calendarView

    }
    
    func tapPost() {
        let newAppointment = newAppointmentViewController(nibName: nil, bundle: nil)
        self.application.window.rootViewController = newAppointment
    }
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem!){
        println(item)
    }

}
