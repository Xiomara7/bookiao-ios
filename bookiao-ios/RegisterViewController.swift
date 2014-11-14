//
//  RegisterViewController.swift
//  bookiao-ios
//
//  Created by Xiomara on 10/29/14.
//  Copyright (c) 2014 UPRRP. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    var customDesign = CustomDesign()
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!){
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = customDesign.UIColorFromRGB(0xE4E4E4)
        super.viewDidLoad()
        
        let application = UIApplication.sharedApplication().delegate as AppDelegate
        
        var tabBar = UITabBarController()
        var tabBarAppearance = UITabBar.appearance()
        var client   = ClientViewController()
        var employee = EmployeeViewController()
        var business = BusinessViewController()
        var requests = HTTPrequests()
        var clientIcon   = UITabBarItem(title: "cliente" , image: UIImage(named: "cliente.png") , tag: 0)
        var employeeIcon = UITabBarItem(title: "empleado", image: UIImage(named: "empleado.png"), tag: 1)
        var businessIcon = UITabBarItem(title: "negocio" , image: UIImage(named: "negocio.png") , tag: 2)
        
        client.tabBarItem   = clientIcon
        business.tabBarItem = businessIcon
        employee.tabBarItem = employeeIcon
        
        var controllers = [business, employee, client]
        
        tabBar.viewControllers = controllers
        tabBar.navigationItem.title = "Registro"
        tabBarAppearance.backgroundImage = UIImage(named: "back.png")
        tabBarAppearance.tintColor = customDesign.UIColorFromRGB(0x00B287)
        
        let postButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: nil, action: Selector("dismiss"))
        self.navigationItem.leftBarButtonItem = postButton
        
        let navBar = UINavigationController(rootViewController: tabBar)
        navBar.navigationBar.backgroundColor = UIColor.blackColor()
        navBar.navigationBar.setBackgroundImage(UIImage(named: "menubar.png"), forBarMetrics: .Default)
        navBar.navigationItem.leftBarButtonItem = postButton
        application.window.rootViewController = navBar
        

    }
    
    func tapPost() {
        println("tappost")
    }

    func tapPostCalendar() {
        println("calendar")
    }
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem!){
        println(item)
    }
    func dismiss() {
        let back = LoginViewController(nibName: nil, bundle: nil)
        self.presentViewController(back, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}




