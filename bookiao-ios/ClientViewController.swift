//
//  ClientViewController.swift
//  bookiao-ios
//
//  Created by Xiomara on 11/1/14.
//  Copyright (c) 2014 UPRRP. All rights reserved.
//

import Alamofire

class ClientViewController: UIViewController {
    var placetxtField: UITextField = UITextField()
    var emailtxtField: UITextField = UITextField()
    var passwordtxtField: UITextField = UITextField()
    var confirmtxtField: UITextField = UITextField()
    var nameTxtField: UITextField = UITextField()
    var localTxtField: UITextField = UITextField()
    var startTimetxtField: UITextField = UITextField()
    var endTimetxtField: UITextField = UITextField()
    let registroButton   = UIButton.buttonWithType(UIButtonType.System) as UIButton
    
    override func viewDidLoad() {
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
        emailtxtField.placeholder = "Correo Electrónico"
        
        passwordtxtField.frame = CGRectMake(20, 170, 275, 40)
        passwordtxtField.backgroundColor = UIColor.whiteColor()
        passwordtxtField.tintColor = UIColor.grayColor()
        passwordtxtField.font = UIFont.systemFontOfSize(14.0)
        passwordtxtField.textAlignment = .Center
        passwordtxtField.placeholder = "Contraseña"
        
        confirmtxtField.frame = CGRectMake(20, 220, 275, 40)
        confirmtxtField.backgroundColor = UIColor.whiteColor()
        confirmtxtField.tintColor = UIColor.grayColor()
        confirmtxtField.font = UIFont.systemFontOfSize(14.0)
        confirmtxtField.textAlignment = .Center
        confirmtxtField.placeholder = "Número de teléfono"
        
        registroButton.frame = CGRectMake(20, 440, 275, 45)
        registroButton.backgroundColor = customDesign.UIColorFromRGB(0x34A3DB)
        registroButton.tintColor = UIColor.whiteColor()
        registroButton.titleLabel?.font = UIFont.boldSystemFontOfSize(16.0)
        registroButton.setTitle("Registrarme", forState: UIControlState.Normal)
        registroButton.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(emailtxtField)
        self.view.addSubview(placetxtField)
        self.view.addSubview(passwordtxtField)
        self.view.addSubview(registroButton)
        self.view.addSubview(confirmtxtField)
        self.view.addSubview(nameTxtField)

        // Do any additional setup after loading the view.
    }
    
    func tapPost() {
        println("tappost")
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.navigationItem.title = "Cliente"

        self.tabBarController?.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.tabBarController?.navigationController?.navigationBar.backgroundColor = UIColor.blackColor()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func buttonAction(sender:UIButton!) {
        let request = HTTPrequests()
        let name = nameTxtField.text
        let email = emailtxtField.text
        let phone = confirmtxtField.text
        let password = passwordtxtField.text
        let location = ""
        let manager = ""
        let business = ""
        let usuario = "cliente"
        
        request.registerRequest(email, name: name, phone: phone, password: password, location: location, manager: manager, business: business, bID:0, usuario: usuario)
        let views = ViewController(nibName: nil, bundle: nil)
        self.presentViewController(views, animated: true, completion: nil)
        
    }
    
}