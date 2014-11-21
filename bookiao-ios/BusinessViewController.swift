//
//  BusinessViewController.swift
//  bookiao-ios
//
//  Created by Xiomara on 11/1/14.
//  Copyright (c) 2014 UPRRP. All rights reserved.
//


class BusinessViewController: UIViewController {
    
    var emailtxtField: UITextField = CustomDesign.getNameTxtField

    var subscription: UILabel = UILabel()
    var paragraph: UILabel = UILabel()
    var rButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
    
    override func viewDidLoad() {
        let customDesign = CustomDesign()
        self.view.backgroundColor = customDesign.UIColorFromRGB(0xE4E4E4)
        super.viewDidLoad()
        
        emailtxtField.frame = CGRectMake(20, self.view.bounds.height / 2, self.view.bounds.width - 40, 40)
        emailtxtField.placeholder = "Correo Electrónico"
        
        subscription.frame = CGRectMake(20, 100, self.view.bounds.width - 40, 40)
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
        let email = emailtxtField.text

        emailtxtField.text = ""
        request.subscription(email)
        
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