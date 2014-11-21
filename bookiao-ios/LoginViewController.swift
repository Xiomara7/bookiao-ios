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

class LoginViewController: UIViewController {
    
    let loader = UIActivityIndicatorView(frame: CGRectMake(0.0, 0.0, 40.0, 40.0))
    let requests = HTTPrequests()
    let customDesign = CustomDesign()
    let application  = UIApplication.sharedApplication().delegate as AppDelegate
    
    var emailtxtField:  UITextField = CustomDesign.getNameTxtField
    var passwdtxtField: UITextField = CustomDesign.getNameTxtField
    
    let nameLabel  = UIButton.buttonWithType(UIButtonType.System) as UIButton
    let nuevoLabel = UIButton.buttonWithType(UIButtonType.System) as UIButton
    let ingresoButton  = UIButton.buttonWithType(UIButtonType.System) as UIButton
    let registroButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
    
    override func viewDidLoad() {
        self.view.backgroundColor = customDesign.UIColorFromRGB(0x224656)
        super.viewDidLoad()
        
        nameLabel.frame = CGRectMake(self.view.bounds.width / 12, 70, self.view.bounds.width - 40, 40)
        nameLabel.backgroundColor = customDesign.UIColorFromRGB(0x224656)
        nameLabel.tintColor = UIColor.whiteColor()
        nameLabel.titleLabel?.font = UIFont.boldSystemFontOfSize(40.0)
        nameLabel.setTitle("Bookiao", forState: UIControlState.Normal)
        nameLabel.addTarget(self, action: "buttonAction", forControlEvents: UIControlEvents.TouchUpInside)
        
        emailtxtField.frame = CGRectMake(20, 160, self.view.bounds.width - 40, 40)
        emailtxtField.placeholder = "Correo electrónico"
        
        passwdtxtField.frame = CGRectMake(20, 215, self.view.bounds.width - 40, 40)
        passwdtxtField.secureTextEntry = true
        passwdtxtField.placeholder = "Contraseña"
        
        ingresoButton.frame = CGRectMake(20, 290, self.view.bounds.width - 40, 40)
        ingresoButton.backgroundColor = customDesign.UIColorFromRGB(0x00B287)
        ingresoButton.tintColor = UIColor.whiteColor()
        ingresoButton.titleLabel?.font = UIFont.boldSystemFontOfSize(16.0)
        ingresoButton.setTitle("Ingreso", forState: UIControlState.Normal)
        ingresoButton.addTarget(self, action: "buttonActionLogin", forControlEvents: UIControlEvents.TouchUpInside)
        
        registroButton.frame = CGRectMake(20, 440, self.view.bounds.width - 40, 40)
        registroButton.backgroundColor = customDesign.UIColorFromRGB(0x34A3DB)
        registroButton.tintColor = UIColor.whiteColor()
        registroButton.titleLabel?.font = UIFont.boldSystemFontOfSize(16.0)
        registroButton.setTitle("Registrarme", forState: UIControlState.Normal)
        registroButton.addTarget(self, action: "buttonActionRegister", forControlEvents: UIControlEvents.TouchUpInside)

        nuevoLabel.frame = CGRectMake(20, 390, self.view.bounds.width - 40, 40)
        nuevoLabel.backgroundColor = customDesign.UIColorFromRGB(0x224656)
        nuevoLabel.tintColor = UIColor.whiteColor()
        nuevoLabel.titleLabel?.font = UIFont.boldSystemFontOfSize(14.0)
        nuevoLabel.setTitle("__________   Eres Nuevo?   __________", forState: UIControlState.Normal)
        nuevoLabel.addTarget(self, action: "buttonAction", forControlEvents: UIControlEvents.TouchUpInside)
    
        requests.getBusinesses()
        requests.getClients()
        requests.getEmployees()
        requests.getServices()
        
        loader.hidesWhenStopped = true
        loader.center = CGPointMake(180, 270);
        
        self.view.addSubview(ingresoButton)
        self.view.addSubview(registroButton)
        self.view.addSubview(emailtxtField)
        self.view.addSubview(passwdtxtField)
        self.view.addSubview(nameLabel)
        self.view.addSubview(nuevoLabel)
        self.view.addSubview(loader)
    }
    
    override func viewWillAppear(animated: Bool) {
        emailtxtField.text = ""
        passwdtxtField.text = ""
        loader.stopAnimating()
    }
    
    func buttonAction() {
        println("false button")
    }
    
    func buttonActionLogin() {
        
        let email = emailtxtField.text
        let password = passwdtxtField.text
        
        requests.getUserInfo(email)
        requests.loginRequest(email, password: password, usuario: "tipo de usuario")
        
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