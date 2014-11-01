//
//  ClientViewController.swift
//  bookiao-ios
//
//  Created by Xiomara on 11/1/14.
//  Copyright (c) 2014 UPRRP. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ClientViewController: UIViewController {
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!){
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        let customDesign = CustomDesign()
        self.view.backgroundColor = customDesign.UIColorFromRGB(0xE4E4E4)
        super.viewDidLoad()
        
        var placetxtField: UITextField = UITextField()
        placetxtField.frame = CGRectMake(20, 70, 275, 40)
        placetxtField.backgroundColor = UIColor.whiteColor()
        placetxtField.tintColor = UIColor.grayColor()
        placetxtField.font = UIFont.systemFontOfSize(14.0)
        placetxtField.textAlignment = .Center
        placetxtField.placeholder = "Negocio"
        
        var emailtxtField: UITextField = UITextField()
        emailtxtField.frame = CGRectMake(20, 120, 275, 40)
        emailtxtField.backgroundColor = UIColor.whiteColor()
        emailtxtField.tintColor = UIColor.grayColor()
        emailtxtField.font = UIFont.systemFontOfSize(14.0)
        emailtxtField.textAlignment = .Center
        emailtxtField.placeholder = "Email"
        
        var passwordtxtField: UITextField = UITextField()
        passwordtxtField.frame = CGRectMake(20, 170, 275, 40)
        passwordtxtField.backgroundColor = UIColor.whiteColor()
        passwordtxtField.tintColor = UIColor.grayColor()
        passwordtxtField.font = UIFont.systemFontOfSize(14.0)
        passwordtxtField.textAlignment = .Center
        passwordtxtField.placeholder = "Password"
        
        var confirmtxtField: UITextField = UITextField()
        confirmtxtField.frame = CGRectMake(20, 220, 275, 40)
        confirmtxtField.backgroundColor = UIColor.whiteColor()
        confirmtxtField.tintColor = UIColor.grayColor()
        confirmtxtField.font = UIFont.systemFontOfSize(14.0)
        confirmtxtField.textAlignment = .Center
        confirmtxtField.placeholder = "Confirm"
        
        var nameTxtField: UITextField = UITextField()
        nameTxtField.frame = (CGRectMake(20, 270, 275, 40))
        nameTxtField.backgroundColor = UIColor.whiteColor()
        nameTxtField.tintColor = UIColor.grayColor()
        nameTxtField.font = UIFont.systemFontOfSize(14.0)
        nameTxtField.textAlignment = .Center
        nameTxtField.placeholder = "Nombre"
        
        var localTxtField: UITextField = UITextField()
        localTxtField.frame = (CGRectMake(20, 320, 275, 40))
        localTxtField.backgroundColor  = UIColor.whiteColor()
        localTxtField.tintColor = UIColor.blackColor()
        localTxtField.font = UIFont.systemFontOfSize(14.0)
        localTxtField.textAlignment = .Center
        localTxtField.placeholder = "Localización"
        
        var startTimetxtField: UITextField = UITextField()
        startTimetxtField.frame = CGRectMake(20, 370, 120, 40)
        startTimetxtField.backgroundColor = UIColor.whiteColor()
        startTimetxtField.tintColor = UIColor.grayColor()
        startTimetxtField.font = UIFont.systemFontOfSize(14.0)
        startTimetxtField.textAlignment = .Center
        startTimetxtField.placeholder = "Abre"
        
        var endTimetxtField: UITextField = UITextField()
        endTimetxtField.frame = CGRectMake(175, 370, 120, 40)
        endTimetxtField.backgroundColor = UIColor.whiteColor()
        endTimetxtField.font = UIFont.systemFontOfSize(14.0)
        endTimetxtField.tintColor = UIColor.grayColor()
        endTimetxtField.textAlignment = .Center
        endTimetxtField.placeholder = "Cierra"
        
        let registroButton   = UIButton.buttonWithType(UIButtonType.System) as UIButton
        registroButton.frame = CGRectMake(20, 440, 275, 45)
        registroButton.backgroundColor = customDesign.UIColorFromRGB(0x34A3DB)
        registroButton.tintColor = UIColor.whiteColor()
        registroButton.titleLabel?.font = UIFont.boldSystemFontOfSize(16.0)
        registroButton.setTitle("Registrarme", forState: UIControlState.Normal)
        registroButton.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(emailtxtField)
        self.view.addSubview(placetxtField)
        self.view.addSubview(passwordtxtField)
        self.view.addSubview(startTimetxtField)
        self.view.addSubview(localTxtField)
        self.view.addSubview(endTimetxtField)
        self.view.addSubview(registroButton)
        self.view.addSubview(confirmtxtField)
        self.view.addSubview(nameTxtField)

        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}