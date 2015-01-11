//
//  LoginViewController.swift
//  bookiao-ios
//
//  Created by Xiomara on 10/17/14.
//  Copyright (c) 2014 UPRRP. All rights reserved.
//

import Foundation
import UIKit
import CoreData


extension String {
    func isEmail() -> Bool {
        let regex = NSRegularExpression(pattern: "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,4}$", options: .CaseInsensitive, error: nil)
        return regex?.firstMatchInString(self, options: nil, range: NSMakeRange(0, countElements(self))) != nil
    }
}

class LoginViewController: UIViewController {
    
    let requests = HTTPrequests()
    let customDesign = CustomDesign()
    let application  = UIApplication.sharedApplication().delegate as AppDelegate
    
    var emailtxtField: UITextField = CustomDesign.getNameTxtField
    var passwtxtField: UITextField = CustomDesign.getNameTxtField
    
    let iconImage  = UIButton.buttonWithType(UIButtonType.System) as UIButton
    let thename_Label = UIButton.buttonWithType(UIButtonType.System) as UIButton
    let isitnew_Label = UIButton.buttonWithType(UIButtonType.System) as UIButton
    let ingresoButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
    let registrButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
    
    let indicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        self.view.backgroundColor = customDesign.UIColorFromRGB(0x224656)
        super.viewDidLoad()
        
        iconImage.frame = CGRectMake(self.view.bounds.width / 2 - 40, 40, 80, 80)
        
        thename_Label.frame = CGRectMake(self.view.bounds.width / 12, 110, self.view.bounds.width - 40, 40)
        isitnew_Label.frame = CGRectMake(20, 390, self.view.bounds.width - 40, 40)
        emailtxtField.frame = CGRectMake(20, 160, self.view.bounds.width - 40, 40)
        passwtxtField.frame = CGRectMake(20, 215, self.view.bounds.width - 40, 40)
        ingresoButton.frame = CGRectMake(20, 290, self.view.bounds.width - 40, 40)
        registrButton.frame = CGRectMake(20, 440, self.view.bounds.width - 40, 40)

        iconImage.setBackgroundImage(UIImage(named: "icon.png"), forState: .Normal)
        
        thename_Label.backgroundColor = customDesign.UIColorFromRGB(0x224656)
        ingresoButton.backgroundColor = customDesign.UIColorFromRGB(0x00B287)
        registrButton.backgroundColor = customDesign.UIColorFromRGB(0x34A3DB)
        isitnew_Label.backgroundColor = customDesign.UIColorFromRGB(0x224656)
        
        thename_Label.tintColor = UIColor.whiteColor()
        ingresoButton.tintColor = UIColor.whiteColor()
        registrButton.tintColor = UIColor.whiteColor()
        isitnew_Label.tintColor = UIColor.whiteColor()
        
        thename_Label.titleLabel?.font = UIFont.boldSystemFontOfSize(40.0)
        ingresoButton.titleLabel?.font = UIFont.boldSystemFontOfSize(16.0)
        registrButton.titleLabel?.font = UIFont.boldSystemFontOfSize(16.0)
        isitnew_Label.titleLabel?.font = UIFont.boldSystemFontOfSize(14.0)
    
        emailtxtField.placeholder = "Correo electrónico"
        passwtxtField.placeholder = "Contraseña"
        
        
        thename_Label.setTitle("Bookiao", forState: UIControlState.Normal)
        ingresoButton.setTitle("Ingreso", forState: UIControlState.Normal)
        registrButton.setTitle("Registrarme", forState: UIControlState.Normal)
        isitnew_Label.setTitle("__________   Eres Nuevo?   __________", forState: UIControlState.Normal)
        
        thename_Label.addTarget(self, action: "buttonAction", forControlEvents: .TouchUpInside)
        isitnew_Label.addTarget(self, action: "buttonAction", forControlEvents: .TouchUpInside)
        ingresoButton.addTarget(self, action: "buttonActionLogin", forControlEvents: .TouchUpInside)
        registrButton.addTarget(self, action: "buttonActionRegister", forControlEvents: .TouchUpInside)
        
        emailtxtField.keyboardType = UIKeyboardType.EmailAddress
        passwtxtField.secureTextEntry = true
    
        requests.getClients()
        requests.getBusinesses()
        requests.getEmployees()
        requests.getServices()
        
        self.view.addSubview(iconImage)
        self.view.addSubview(indicator)
        self.view.addSubview(ingresoButton)
        self.view.addSubview(registrButton)
        self.view.addSubview(emailtxtField)
        self.view.addSubview(passwtxtField)
        self.view.addSubview(thename_Label)
        self.view.addSubview(isitnew_Label)
    }
    
    override func viewWillAppear(animated: Bool) {
        emailtxtField.text = ""
        passwtxtField.text = ""
    }
    
    func buttonAction() {
        println("false button")
    }
    
    func buttonActionLogin() {
        let email  = emailtxtField.text
        let passwd = passwtxtField.text
        
        if email.isEmail() {
            requests.loginRequest(email, password: passwd, completion: { (str, error) -> Void in
            if let token = str {DataManager.sharedManager.token = str!
            dispatch_async(dispatch_get_main_queue(), {
            HTTPrequests.sharedManager.getUserInfo(email, completion: { (str, error) -> Void in
                if let ok = str {dispatch_async(dispatch_get_main_queue(), {
                    let views = ViewController()
                    self.presentViewController(views, animated: true, completion: nil)
                })}
            })})}
            else {
                let alert = UIAlertView(title: "Error!", message: DataManager.sharedManager.alertm,
                    delegate: nil, cancelButtonTitle: "OK")
                    dispatch_async(dispatch_get_main_queue(), { alert.show()
                    self.emailtxtField.text = ""
                    self.passwtxtField.text = ""
                });
            }})
        }
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    func buttonActionRegister() {
        println("Button tapped")
        let register = RegisterViewController(nibName: nil, bundle: nil)
        self.presentViewController(register, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}