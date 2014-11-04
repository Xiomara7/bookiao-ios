//
//  ViewController.swift
//  bookiao-ios
//
//  Created by Xiomara on 9/30/14.
//  Copyright (c) 2014 UPRRP. All rights reserved.
//

import UIKit
import CoreData

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
        
        let navBarAppointment = UINavigationController(rootViewController: appointments)
        let navBarHistory = UINavigationController(rootViewController: history)
        let navBarprofile = UINavigationController(rootViewController: profile)
        
        let controllers = [navBarAppointment, navBarHistory, navBarprofile]
        
        let tabBar = UITabBarController()
        var tabBarAppearance = UITabBar.appearance()
        tabBarAppearance.tintColor = customDesign.UIColorFromRGB(0x00B287)
        tabBar.viewControllers = controllers

        let application = UIApplication.sharedApplication().delegate as AppDelegate
        application.window.rootViewController = tabBar
        
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
