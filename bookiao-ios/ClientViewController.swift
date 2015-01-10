//
//  ClientViewController.swift
//  bookiao-ios
//
//  Created by Xiomara on 11/1/14.
//  Copyright (c) 2014 UPRRP. All rights reserved.
//

import Alamofire

class ClientViewController: UIViewController {
    var emailTxtField: UITextField = CustomDesign.getNameTxtField
    var passwTxtField: UITextField = CustomDesign.getNameTxtField
    var confirmsField: UITextField = CustomDesign.getNameTxtField
    var nameTextField: UITextField = CustomDesign.getNameTxtField
    
    let registerButton   = UIButton.buttonWithType(UIButtonType.System) as UIButton
    
    override func viewDidLoad() {
        let customDesign = CustomDesign()
        self.view.backgroundColor = customDesign.UIColorFromRGB(0xE4E4E4)
        super.viewDidLoad()
        
        nameTextField.frame  = CGRectMake(20,  70, self.view.bounds.width - 40, 40)
        emailTxtField.frame  = CGRectMake(20, 120, self.view.bounds.width - 40, 40)
        passwTxtField.frame  = CGRectMake(20, 170, self.view.bounds.width - 40, 40)
        confirmsField.frame  = CGRectMake(20, 220, self.view.bounds.width - 40, 40)
        registerButton.frame = CGRectMake(20, 440, self.view.bounds.width - 40, 40)
        
        nameTextField.placeholder = "Nombre"
        emailTxtField.placeholder = "Correo Electrónico"
        passwTxtField.placeholder = "Contraseña"
        confirmsField.placeholder = "Número de teléfono"
        
        registerButton.backgroundColor = customDesign.UIColorFromRGB(0x34A3DB)
        registerButton.tintColor = UIColor.whiteColor()
        registerButton.titleLabel?.font = UIFont.boldSystemFontOfSize(16.0)
        registerButton.setTitle("Registrarme", forState: UIControlState.Normal)
        registerButton.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview( emailTxtField)
        self.view.addSubview( passwTxtField)
        self.view.addSubview( confirmsField)
        self.view.addSubview( nameTextField)
        self.view.addSubview(registerButton)
        
    }

    func dismiss() {
        let back = LoginViewController(nibName: nil, bundle: nil)
        self.presentViewController(back, animated: true, completion: nil)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.navigationItem.title = "Cliente"

        self.tabBarController?.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.tabBarController?.navigationController?.navigationBar.backgroundColor = UIColor.whiteColor()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func buttonAction(sender:UIButton!) {
        let request = HTTPrequests()
        
        let name  = nameTextField.text
        let email = emailTxtField.text
        let phone = confirmsField.text
        let passw = passwTxtField.text
        
        request.registerRequest(email, name: name, phone: phone, passwd: passw) {(str, error) -> Void in
            if let ok = str {request.authRequest(email, passwd: passw, completion:{(str, error) -> Void in
            if let ok = str {request.clientsReq (email, name: name, phone: phone, completion: {(str, error) -> Void in
            if let ok = str {request.getUserInfo(email, completion: { (str, error) -> Void in
            if let ok = str {
            dispatch_async(dispatch_get_main_queue(), {
                let views = ViewController()
                self.presentViewController(views, animated: true, completion: nil)
            })}})}})}})}
        }
    }
}