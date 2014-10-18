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
        
        var nameLabel: UILabel = UILabel()
        nameLabel.frame = CGRectMake(130, 300, 220, 40)
        nameLabel.tintColor = UIColor.whiteColor()
        nameLabel.text = "Bookiao"
        
        var emailtxtField: UITextField = UITextField()
        emailtxtField.frame = CGRectMake(130, 420, 220, 40)
        emailtxtField.backgroundColor = UIColor.whiteColor()
        emailtxtField.tintColor = UIColor.grayColor()
        emailtxtField.placeholder = "Correo electrónico"
        
        var passwdtxtField: UITextField = UITextField()
        passwdtxtField.frame = CGRectMake(130, 370, 220, 40)
        passwdtxtField.backgroundColor = UIColor.whiteColor()
        passwdtxtField.tintColor = UIColor.grayColor()
        passwdtxtField.placeholder = "Contraseña"
        
        self.view.addSubview(button)
        self.view.addSubview(emailtxtField)
        self.view.addSubview(passwdtxtField)
    }
    
    func buttonAction(sender:UIButton!)
    {
        println("Button tapped")
        delegate
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}