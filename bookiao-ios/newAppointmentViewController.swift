//
//  newAppointmentViewController.swift
//  bookiao-ios
//
//  Created by Xiomara on 11/5/14.
//  Copyright (c) 2014 UPRRP. All rights reserved.
//

import Foundation

class newAppointmentViewController: UIViewController {
    var placetxtField: UITextField = UITextField()
    var emailtxtField: UITextField = UITextField()
    var passwordtxtField: UITextField = UITextField()
    var confirmtxtField: UITextField = UITextField()
    var nameTxtField: UITextField = UITextField()
    var localTxtField: UITextField = UITextField()
    var startTimetxtField: UITextField = UITextField()
    var endTimetxtField: UITextField = UITextField()
    let registroButton   = UIButton.buttonWithType(UIButtonType.System) as UIButton
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!){
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let customDesign = CustomDesign()
        self.view.backgroundColor = customDesign.UIColorFromRGB(0xE4E4E4)
        super.viewDidLoad()
        
        
        nameTxtField.frame = (CGRectMake(20, 70, 275, 40))
        nameTxtField.backgroundColor = UIColor.whiteColor()
        nameTxtField.tintColor = UIColor.grayColor()
        nameTxtField.font = UIFont.systemFontOfSize(14.0)
        nameTxtField.textAlignment = .Center
        nameTxtField.placeholder = "Nombre"
        
        
        emailtxtField.frame = CGRectMake(20, 120, 275, 40)
        emailtxtField.backgroundColor = UIColor.whiteColor()
        emailtxtField.tintColor = UIColor.grayColor()
        emailtxtField.font = UIFont.systemFontOfSize(14.0)
        emailtxtField.textAlignment = .Center
        emailtxtField.placeholder = "Email"
        
        passwordtxtField.frame = CGRectMake(20, 170, 275, 40)
        passwordtxtField.backgroundColor = UIColor.whiteColor()
        passwordtxtField.tintColor = UIColor.grayColor()
        passwordtxtField.font = UIFont.systemFontOfSize(14.0)
        passwordtxtField.textAlignment = .Center
        passwordtxtField.placeholder = "Password"
        
        confirmtxtField.frame = CGRectMake(20, 220, 275, 40)
        confirmtxtField.backgroundColor = UIColor.whiteColor()
        confirmtxtField.tintColor = UIColor.grayColor()
        confirmtxtField.font = UIFont.systemFontOfSize(14.0)
        confirmtxtField.textAlignment = .Center
        confirmtxtField.placeholder = "Confirm"
        
        
        
        
        localTxtField.frame = (CGRectMake(20, 320, 275, 40))
        localTxtField.backgroundColor  = UIColor.whiteColor()
        localTxtField.tintColor = UIColor.blackColor()
        localTxtField.font = UIFont.systemFontOfSize(14.0)
        localTxtField.textAlignment = .Center
        localTxtField.placeholder = "Localización"
        
        startTimetxtField.frame = CGRectMake(20, 370, 120, 40)
        startTimetxtField.backgroundColor = UIColor.whiteColor()
        startTimetxtField.tintColor = UIColor.grayColor()
        startTimetxtField.font = UIFont.systemFontOfSize(14.0)
        startTimetxtField.textAlignment = .Center
        startTimetxtField.placeholder = "Abre"
        
        endTimetxtField.frame = CGRectMake(175, 370, 120, 40)
        endTimetxtField.backgroundColor = UIColor.whiteColor()
        endTimetxtField.font = UIFont.systemFontOfSize(14.0)
        endTimetxtField.tintColor = UIColor.grayColor()
        endTimetxtField.textAlignment = .Center
        endTimetxtField.placeholder = "Cierra"
        
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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}