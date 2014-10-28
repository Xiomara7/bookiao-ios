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
        self.view.backgroundColor = customDesign.UIColorFromRGB(0x224656)
        super.viewDidLoad()
        
        var nameLabel: UILabel = UILabel()
        var labelapp = UILabel.appearance()
        nameLabel.frame = CGRectMake(110, 70, 160, 45)
        nameLabel.text = "Bookiao"
        labelapp.text = "Bookiao"
        nameLabel.tintColor = UIColor.whiteColor()
        labelapp.font = UIFont.systemFontOfSize(40.0)
        labelapp.tintColor = customDesign.UIColorFromRGB(0x000000)

        var emailtxtField: UITextField = UITextField()
        emailtxtField.frame = CGRectMake(20, 160, 330, 45)
        emailtxtField.backgroundColor = UIColor.whiteColor()
        emailtxtField.tintColor = UIColor.grayColor()
        emailtxtField.placeholder = "Correo electrónico"
        
        var passwdtxtField: UITextField = UITextField()
        passwdtxtField.frame = CGRectMake(20, 215, 330, 45)
        passwdtxtField.backgroundColor = UIColor.whiteColor()
        passwdtxtField.tintColor = UIColor.grayColor()
        passwdtxtField.placeholder = "Contraseña"
        
        let ingresoButton   = UIButton.buttonWithType(UIButtonType.System) as UIButton
        ingresoButton.frame = CGRectMake(20, 290, 330, 45)
        ingresoButton.backgroundColor = customDesign.UIColorFromRGB(0x00B287)
        ingresoButton.tintColor = UIColor.whiteColor()
        ingresoButton.setTitle("Ingreso", forState: UIControlState.Normal)
        ingresoButton.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        
        let registroButton   = UIButton.buttonWithType(UIButtonType.System) as UIButton
        registroButton.frame = CGRectMake(20, 440, 330, 45)
        registroButton.backgroundColor = customDesign.UIColorFromRGB(0x34A3DB)
        registroButton.tintColor = UIColor.whiteColor()
        registroButton.setTitle("Registrarme", forState: UIControlState.Normal)
        registroButton.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        
        var addedLabel: UILabel = UILabel()
        var addedApp = UILabel.appearance()
        addedLabel.frame = CGRectMake(40, 390, 330, 45)
        addedLabel.text = "__________   Eres Nuevo?   __________"
        addedLabel.tintColor = UIColor.whiteColor()
        addedApp.font = UIFont.systemFontOfSize(40.0)
        addedApp.tintColor = customDesign.UIColorFromRGB(0x000000)
        
        self.view.addSubview(ingresoButton)
        self.view.addSubview(registroButton)
        self.view.addSubview(emailtxtField)
        self.view.addSubview(passwdtxtField)
        self.view.addSubview(nameLabel)
        self.view.addSubview(addedLabel)
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