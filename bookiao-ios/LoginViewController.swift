//
//  LoginViewController.swift
//  bookiao-ios
//
//  Created by Xiomara on 10/17/14.
//  Copyright (c) 2014 UPRRP. All rights reserved.
//

import Foundation

import UIKit

class LoginViewController: UIViewController {
    
    var customDesign = CustomDesign()
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!){
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "backg.png"))
        super.viewDidLoad()
        
        let button   = UIButton.buttonWithType(UIButtonType.System) as UIButton
        button.frame = CGRectMake(130, 480, 220, 40)
        button.backgroundColor = customDesign.UIColorFromRGB(0x93D946)
        button.tintColor = UIColor.whiteColor()
        button.setTitle("Ingreso", forState: UIControlState.Normal)
        button.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(button)
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