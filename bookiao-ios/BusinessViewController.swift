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
    
    var subscription: UILabel = UILabel()
    var paragraph: UILabel = UILabel()
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
        
        emailtxtField.frame = CGRectMake(20, self.view.bounds.height / 2, self.view.bounds.width - 40, 40)
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
        
        nameTxtField.frame = CGRectMake(20, 220, self.view.bounds.width - 40, 40)
        nameTxtField.backgroundColor = UIColor.whiteColor()
        nameTxtField.tintColor = UIColor.grayColor()
        nameTxtField.font = UIFont.systemFontOfSize(14.0)
        nameTxtField.textAlignment = .Center
        nameTxtField.placeholder = "Nombre del dueño"
        
        confirmtxtField.frame = (CGRectMake(20, 270, self.view.bounds.width - 40, 40))
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
        
        subscription.frame = CGRectMake(20, 100, self.view.bounds.width - 40, 40)
        subscription.font = UIFont.boldSystemFontOfSize(18.0)
        subscription.textAlignment = .Center
        subscription.text = "Subscribete"
        
        paragraph.frame = CGRectMake(20, 100, self.view.bounds.width - 40, 200)
        paragraph.font = UIFont.systemFontOfSize(14.0)
        paragraph.textAlignment = .Center
        paragraph.lineBreakMode = NSLineBreakMode.ByWordWrapping
        paragraph.numberOfLines = 0
        paragraph.text = "Hasta este momento nuestro app tiene solo un negocio beta. Si deseas ser parte del grupo de negocios beta, por favor déjanos tu correo electrónico utilizando los campos de abajo. \r \r Atentamente H3 at Bookiao."
        
        rButton.frame = CGRectMake(20, self.view.bounds.height / 2 + 50, self.view.bounds.width - 40, 40)
        rButton.backgroundColor = customDesign.UIColorFromRGB(0x34A3DB)
        rButton.tintColor = UIColor.whiteColor()
        rButton.titleLabel?.font = UIFont.boldSystemFontOfSize(16.0)
        rButton.setTitle("Subscribeme", forState: UIControlState.Normal)
        rButton.addTarget(self, action: "buttonActionBusiness", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(emailtxtField)
        self.view.addSubview(subscription)
        self.view.addSubview(paragraph)
        self.view.addSubview(rButton)
//        self.view.addSubview(placetxtField)
//        self.view.addSubview(passwordtxtField)
//        self.view.addSubview(localTxtField)
//        self.view.addSubview(confirmtxtField)
//        self.view.addSubview(nameTxtField)
//        self.view.addSubview(startTimetxtField)
//        self.view.addSubview(endTimetxtField)

        
        // Do any additional setup after loading the view.
        
        let postButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("dismiss"))
        self.navigationItem.leftBarButtonItem = postButton
    }
    
    func dismiss() {
        let back = LoginViewController(nibName: nil, bundle: nil)
        self.presentViewController(back, animated: true, completion: nil)
    }
    
    func buttonActionBusiness() {
        let request = HTTPrequests()
        let name = placetxtField.text
        let email = emailtxtField.text
        let phone = confirmtxtField.text
        let password = passwordtxtField.text
        let location = localTxtField.text
        let manager = nameTxtField.text
        let business = ""
        let usuario = "negocio"

        request.subscription(email)
        
//        request.getUserInfo(email)
//        request.registerRequest(email, name: name, phone: phone, password: password, location: location, manager: manager, business:  business, bID:0, usuario: usuario)
//        let views = ViewController(nibName: nil, bundle: nil)
//        self.presentViewController(views, animated: true, completion: nil)
        
        emailtxtField.text = ""
        let alert = UIAlertView(title: "Thanks!", message: "We'll contact you soon!", delegate: self, cancelButtonTitle: "OK")
        alert.show()
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.navigationItem.title = "Negocio"
        self.tabBarController?.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.tabBarController?.navigationController?.navigationBar.backgroundColor = UIColor.whiteColor()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}