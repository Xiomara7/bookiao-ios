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
        let login   = LoginViewController(nibName: nil, bundle: nil)
        let citasTextLabel    = UITabBarItem(title: "", image: UIImage(named: "booking.png"), tag: 0)
        let historyTextLabel  = UITabBarItem(title: "", image: UIImage(named: "history.png"), tag: 1)
        let settingsTextLabel = UITabBarItem(title: "", image: UIImage(named: "profile.png"), tag: 2)
        
        appointments.tabBarItem = citasTextLabel
        history.tabBarItem = historyTextLabel
        profile.tabBarItem = settingsTextLabel
        
        appointments.tabBarItem.setTitlePositionAdjustment(UIOffsetMake(0, -500))
        history.tabBarItem.setTitlePositionAdjustment(UIOffsetMake(0, 0))
        profile.tabBarItem.setTitlePositionAdjustment(UIOffsetMake(0, 0))
        
        let controllers = [appointments, history, profile]
        var tabBar = UITabBarController()
        var tabBarAppearance = UITabBar.appearance()
        var img = UIImage(named: "post")
        var postButton = UIBarButtonItem(image: img, style: UIBarButtonItemStyle.Plain, target: self, action: Selector("didTapConnect"))
        tabBar.viewControllers = controllers
        tabBarAppearance.tintColor = customDesign.UIColorFromRGB(0x00B287)
        
        self.view.addSubview(tabBar.view)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
