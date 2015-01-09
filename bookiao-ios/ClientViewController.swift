//
//  ClientViewController.swift
//  bookiao-ios
//
//  Created by Xiomara on 11/1/14.
//  Copyright (c) 2014 UPRRP. All rights reserved.
//

import Alamofire

class ClientViewController: UIViewController {
    var emailtxtField: UITextField = CustomDesign.getNameTxtField
    var passwordtxtField: UITextField = CustomDesign.getNameTxtField
    var confirmtxtField: UITextField = CustomDesign.getNameTxtField
    var nameTxtField: UITextField = CustomDesign.getNameTxtField
    
    let registroButton   = UIButton.buttonWithType(UIButtonType.System) as UIButton
    
    override func viewDidLoad() {
        let customDesign = CustomDesign()
        self.view.backgroundColor = customDesign.UIColorFromRGB(0xE4E4E4)
        super.viewDidLoad()
        
        nameTxtField.frame = (CGRectMake(20, 70, self.view.bounds.width - 40, 40))
        emailtxtField.frame = CGRectMake(20, 120, self.view.bounds.width - 40, 40)
        passwordtxtField.frame = CGRectMake(20, 170, self.view.bounds.width - 40, 40)
        confirmtxtField.frame = CGRectMake(20, 220, self.view.bounds.width - 40, 40)

        nameTxtField.placeholder = "Nombre"
        emailtxtField.placeholder = "Correo Electrónico"
        passwordtxtField.placeholder = "Contraseña"
        confirmtxtField.placeholder = "Número de teléfono"
        
        registroButton.frame = CGRectMake(20, 440, self.view.bounds.width - 40, 40)
        registroButton.backgroundColor = customDesign.UIColorFromRGB(0x34A3DB)
        registroButton.tintColor = UIColor.whiteColor()
        registroButton.titleLabel?.font = UIFont.boldSystemFontOfSize(16.0)
        registroButton.setTitle("Registrarme", forState: UIControlState.Normal)
        registroButton.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(emailtxtField)
        self.view.addSubview(passwordtxtField)
        self.view.addSubview(registroButton)
        self.view.addSubview(confirmtxtField)
        self.view.addSubview(nameTxtField)
        
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
        let name = nameTxtField.text
        let email = emailtxtField.text
        let phone = confirmtxtField.text
        let password = passwordtxtField.text
        
        request.getUserInfo(email, completion: { (str, error) -> Void in
            println("hello")
        })
        request.registerRequest(email, name: name, phone: phone, passwd: password) {  (str, error) -> Void in
            if let ok = str {request.authRequest(email, passwd: password, completion:{(str, error) -> Void in
            if let ok = str {request.createClientRequest(email, name: name, phone: phone, completion: { (str, error) -> Void in
            if let ok = str {
                let views = ViewController()
                self.presentViewController(views, animated: true, completion: nil)
            }})}})}
        }
    }
}