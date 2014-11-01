//
//  RegisterViewController.swift
//  bookiao-ios
//
//  Created by Xiomara on 10/29/14.
//  Copyright (c) 2014 UPRRP. All rights reserved.
//

import Foundation
import UIKit
import CoreData

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
        
        let tabBar = UITabBarController()
        var tabBarAppearance = UITabBar.appearance()
        tabBarAppearance.tintColor = customDesign.UIColorFromRGB(0x00B287)
        
        let client   = ClientViewController(nibName: nil, bundle: nil)
        let employee = EmployeeViewController(nibName: nil, bundle: nil)
        let business = BusinessViewController(nibName: nil, bundle: nil)
        
        let clientIcon = UITabBarItem(title: "cliente", image: UIImage(named: "cliente.png"), tag: 0)
        let employeeIcon = UITabBarItem(title: "empleado", image: UIImage(named: "empleado.png"), tag: 1)
        let businessIcon = UITabBarItem(title: "negocio", image: UIImage(named: "negocio.png"), tag: 2)
        
        client.tabBarItem = clientIcon
        employee.tabBarItem = employeeIcon
        business.tabBarItem = businessIcon
        
        let controllers = [business, employee, client]
        tabBar.viewControllers = controllers
        
    }
    
    func buttonAction(sender:UIButton!)
    {
        println("Button tapped")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}




