//
//  BusinessViewController.swift
//  bookiao-ios
//
//  Created by Xiomara on 11/1/14.
//  Copyright (c) 2014 UPRRP. All rights reserved.
//


class BusinessViewController: UIViewController {
    
    var emailtxtField: UITextField = CustomDesign.getNameTxtField
    var subscriptions: UILabel = UILabel()
    
    var paragraph = UILabel()
    var regButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
    
    override func viewDidLoad() {
        let customDesign = CustomDesign()
        self.view.backgroundColor = customDesign.UIColorFromRGB(0xE4E4E4)
        super.viewDidLoad()
        
        regButton.frame = CGRectMake(20, self.view.bounds.height / 2 + 50, self.view.bounds.width - 40, 40)
        paragraph.frame = CGRectMake(20, 100, self.view.bounds.width - 40, 200)
        emailtxtField.frame = CGRectMake(20, self.view.bounds.height / 2, self.view.bounds.width - 40, 40)
        subscriptions.frame = CGRectMake(self.view.bounds.width / 8 - 30 , 100, self.view.bounds.width - 40, 40)
        

        paragraph.font = UIFont.systemFontOfSize(14.0)
        paragraph.text = DataManager.sharedManager.paragraph
        paragraph.textAlignment = .Center
        paragraph.numberOfLines = 0
        paragraph.lineBreakMode = NSLineBreakMode.ByWordWrapping
        
        subscriptions.text = "Subscribete"
        subscriptions.font = UIFont.boldSystemFontOfSize(20.0)
        subscriptions.textAlignment = .Center
        
        emailtxtField.placeholder = "Correo Electrónico"
        
        regButton.backgroundColor = customDesign.UIColorFromRGB(0x34A3DB)
        regButton.tintColor = UIColor.whiteColor()
        regButton.titleLabel?.font = UIFont.boldSystemFontOfSize(16.0)
        regButton.setTitle("Subscribeme", forState: UIControlState.Normal)
        regButton.addTarget(self, action: "buttonActionBusiness", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(paragraph)
        self.view.addSubview(regButton)
        self.view.addSubview(emailtxtField)
        self.view.addSubview(subscriptions)
        
        // Do any additional setup after loading the view.
        
        let postButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("dismiss"))
        self.navigationItem.leftBarButtonItem = postButton
    }
    
    func dismiss() {
        let back = LoginViewController(nibName: nil, bundle: nil)
        self.presentViewController(back, animated: true, completion: nil)
    }
    
    func buttonActionBusiness() {
        let email = emailtxtField.text
        let request = HTTPrequests()

        emailtxtField.text = ""
        request.subscription(email) { (str, error) -> Void in
        if let err = error {let alert = UIAlertView(title: "Trata otra vez!", message: "Ha ocurrido un error", delegate: self, cancelButtonTitle: "OK")
            dispatch_async(dispatch_get_main_queue(), {
                alert.show()
            })
        }
        else {
            let alert = UIAlertView(title: "Gracias!", message: "Te contactaremos pronto!", delegate: self, cancelButtonTitle: "OK")
            dispatch_async(dispatch_get_main_queue(), {
                alert.show()
            })
        }
    }}
    
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