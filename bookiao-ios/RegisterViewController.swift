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
        
        var tabBar = UITabBarController()
        var tabBarAppearance = UITabBar.appearance()
        tabBarAppearance.tintColor = customDesign.UIColorFromRGB(0x00B287)
        
        var client   = ClientViewController()
        var employee = EmployeeViewController()
        var business = BusinessViewController()
        var clientIcon   = UITabBarItem(title: "cliente" , image: UIImage(named: "cliente.png") , tag: 0)
        var employeeIcon = UITabBarItem(title: "empleado", image: UIImage(named: "empleado.png"), tag: 1)
        var businessIcon = UITabBarItem(title: "negocio" , image: UIImage(named: "negocio.png") , tag: 2)
        
        employee.tabBarItem = employeeIcon
        business.tabBarItem = businessIcon
        client.tabBarItem   = clientIcon
        
        let postButton = UIBarButtonItem(image: UIImage(named: "post.png"), style: UIBarButtonItemStyle.Plain, target: self, action: Selector("tapPost"))
        let calendarButton = UIBarButtonItem(image: UIImage(named: "calendar.png"), style: UIBarButtonItemStyle.Plain, target: self, action: Selector("tapPost"))
        var controllers = [business, employee, client]
        tabBar.viewControllers = controllers
        tabBar.navigationItem.title = "Registro"
        tabBar.navigationItem.rightBarButtonItem = postButton
        tabBar.navigationItem.leftBarButtonItem = calendarButton
        
        let navBar = UINavigationController(rootViewController: tabBar)
        navBar.navigationBar.backgroundColor = UIColor.blackColor()
        let application = UIApplication.sharedApplication().delegate as AppDelegate
        application.window.rootViewController = navBar

    }
    
    func tapPost() {
        println("tappost")
    }
    
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem!){
        println(item)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}




