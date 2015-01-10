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
    
    class var sharedManager: ViewController {
        struct Singleton {
            static let instance = ViewController()
        }
        return Singleton.instance
    }
    
    let request = HTTPrequests()
    
    let application  = UIApplication.sharedApplication().delegate as AppDelegate
    let customDesign = CustomDesign()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var tabBar   = UITabBarController()
        var TBdesign = UITabBar.appearance()
        
        var history: UIViewController = HistoryViewController()
        var profile: UIViewController = ProfileViewController()
        var booking: UIViewController = AppointmentsViewController()
        
        var bookingTextLabel  = UITabBarItem(title: "", image: UIImage(named: "booking.png"), tag: 0)
        var historyTextLabel  = UITabBarItem(title: "", image: UIImage(named: "history.png"), tag: 1)
        var settingsTextLabel = UITabBarItem(title: "", image: UIImage(named: "profile.png"), tag: 2)
        
        
        booking.tabBarItem = bookingTextLabel
        history.tabBarItem = historyTextLabel
        profile.tabBarItem = settingsTextLabel
        
        booking.tabBarItem.imageInsets = UIEdgeInsetsMake(4, 0, -4, 0)
        history.tabBarItem.imageInsets = UIEdgeInsetsMake(4, 0, -4, 0)
        profile.tabBarItem.imageInsets = UIEdgeInsetsMake(4, 0, -4, 0)
        
        var controllers = [booking, history, profile]
        
        TBdesign.backgroundImage = UIImage(named: "back.png")
        TBdesign.backgroundColor = customDesign.UIColorFromRGB(0x323C3E)
        TBdesign.tintColor = customDesign.UIColorFromRGB(0x00B287)

        tabBar.viewControllers = controllers
        
        let navBar = UINavigationController(rootViewController: tabBar)
        navBar.navigationBar.backgroundColor = customDesign.UIColorFromRGB(0x323C3E)
        navBar.navigationBar.setBackgroundImage(UIImage(named: "menubar.png"), forBarMetrics:.Default)

        let postButton = UIBarButtonItem(image: UIImage(named: "post.png"), style:.Plain, target: self, action: Selector("tapPost"))
        let dateButton = UIBarButtonItem(image: UIImage(named: "calendar.png"), style: UIBarButtonItemStyle.Plain, target: self, action: Selector("tapPostCalendar"))

        tabBar.navigationItem.rightBarButtonItem = postButton
        tabBar.navigationItem.leftBarButtonItem  = dateButton
        
        application.window.rootViewController = navBar
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tabBarItem.setTitlePositionAdjustment(UIOffsetMake(0, -20))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
