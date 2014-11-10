//
//  BusinessViewController.swift
//  bookiao-ios
//
//  Created by Xiomara on 11/1/14.
//  Copyright (c) 2014 UPRRP. All rights reserved.
//


class BusinessViewController: UIViewController {
    
    var placetxtField: UITextField = UITextField()
    var emailtxtField: UITextField = UITextField()
    var passwordtxtField: UITextField = UITextField()
    var confirmtxtField: UITextField = UITextField()
    var nameTxtField: UITextField = UITextField()
    var localTxtField: UITextField = UITextField()
    var startTimetxtField: UITextField = UITextField()
    var endTimetxtField: UITextField = UITextField()
    var rButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
    
    override func viewDidLoad() {
        let customDesign = CustomDesign()
        self.view.backgroundColor = customDesign.UIColorFromRGB(0xE4E4E4)
        super.viewDidLoad()
        
        placetxtField.frame = CGRectMake(20, 70, self.view.bounds.width - 40, 40)
        placetxtField.backgroundColor = UIColor.whiteColor()
        placetxtField.tintColor = UIColor.grayColor()
        placetxtField.font = UIFont.systemFontOfSize(14.0)
        placetxtField.textAlignment = .Center
        placetxtField.placeholder = "Nombre del negocio"
        
        emailtxtField.frame = CGRectMake(20, 120, self.view.bounds.width - 40, 40)
        emailtxtField.backgroundColor = UIColor.whiteColor()
        emailtxtField.tintColor = UIColor.grayColor()
        emailtxtField.font = UIFont.systemFontOfSize(14.0)
        emailtxtField.textAlignment = .Center
        emailtxtField.placeholder = "Correo Electrónico"
        
        passwordtxtField.frame = CGRectMake(20, 170, self.view.bounds.width - 40, 40)
        passwordtxtField.backgroundColor = UIColor.whiteColor()
        passwordtxtField.tintColor = UIColor.grayColor()
        passwordtxtField.font = UIFont.systemFontOfSize(14.0)
        passwordtxtField.textAlignment = .Center
        passwordtxtField.placeholder = "Contraseña"
        
        nameTxtField.frame = (CGRectMake(20, 270, self.view.bounds.width - 40, 40))
        nameTxtField.backgroundColor = UIColor.whiteColor()
        nameTxtField.tintColor = UIColor.grayColor()
        nameTxtField.font = UIFont.systemFontOfSize(14.0)
        nameTxtField.textAlignment = .Center
        nameTxtField.placeholder = "Nombre del dueño"
        
        confirmtxtField.frame = CGRectMake(20, 220, self.view.bounds.width - 40, 40)
        confirmtxtField.backgroundColor = UIColor.whiteColor()
        confirmtxtField.tintColor = UIColor.grayColor()
        confirmtxtField.font = UIFont.systemFontOfSize(14.0)
        confirmtxtField.textAlignment = .Center
        confirmtxtField.placeholder = "Número telefónico"
        
        localTxtField.frame = (CGRectMake(20, 320, self.view.bounds.width - 40, 40))
        localTxtField.backgroundColor  = UIColor.whiteColor()
        localTxtField.tintColor = UIColor.blackColor()
        localTxtField.font = UIFont.systemFontOfSize(14.0)
        localTxtField.textAlignment = .Center
        localTxtField.placeholder = "Dirección"
        
        startTimetxtField.frame = CGRectMake(20, 370, self.view.bounds.width / 2 - 30 , 40)
        startTimetxtField.backgroundColor = UIColor.whiteColor()
        startTimetxtField.tintColor = UIColor.grayColor()
        startTimetxtField.font = UIFont.systemFontOfSize(14.0)
        startTimetxtField.textAlignment = .Center
        startTimetxtField.placeholder = "Abre"
        
        endTimetxtField.frame = CGRectMake(self.view.bounds.width / 2 + 10, 370, self.view.bounds.width / 2 - 30 , 40)
        endTimetxtField.backgroundColor = UIColor.whiteColor()
        endTimetxtField.font = UIFont.systemFontOfSize(14.0)
        endTimetxtField.tintColor = UIColor.grayColor()
        endTimetxtField.textAlignment = .Center
        endTimetxtField.placeholder = "Cierra"
        
        rButton.frame = CGRectMake(20, 440, self.view.bounds.width - 40, 40)
        rButton.backgroundColor = customDesign.UIColorFromRGB(0x34A3DB)
        rButton.tintColor = UIColor.whiteColor()
        rButton.titleLabel?.font = UIFont.boldSystemFontOfSize(16.0)
        rButton.setTitle("Registrarme", forState: UIControlState.Normal)
        rButton.addTarget(self, action: "buttonActionBusiness", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(emailtxtField)
        self.view.addSubview(placetxtField)
        self.view.addSubview(passwordtxtField)
        self.view.addSubview(startTimetxtField)
        self.view.addSubview(localTxtField)
        self.view.addSubview(endTimetxtField)
        self.view.addSubview(rButton)
        self.view.addSubview(confirmtxtField)
        self.view.addSubview(nameTxtField)

        
        // Do any additional setup after loading the view.
    }
    
    func buttonActionBusiness() {
        let request = HTTPrequests()
        let name = nameTxtField.text
        let email = emailtxtField.text
        let phone = confirmtxtField.text
        let password = passwordtxtField.text
        let location = placetxtField.text
        let manager = ""
        let business = ""
        let usuario = "negocio"
        
        request.registerRequest(email, name: name, phone: phone, password: password, location: location, manager: manager, business: business, bID:0, usuario: usuario)
        let views = ViewController(nibName: nil, bundle: nil)
        self.presentViewController(views, animated: true, completion: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.navigationItem.title = "Negocio"
        self.tabBarController?.navigationController?.navigationBar.tintColor = UIColor.blackColor()
        self.tabBarController?.navigationController?.navigationBar.backgroundColor = UIColor.blackColor()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}