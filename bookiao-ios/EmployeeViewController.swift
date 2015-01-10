//
//  EmployeeViewController.swift
//  bookiao-ios
//
//  Created by Xiomara on 11/1/14.
//  Copyright (c) 2014 UPRRP. All rights reserved.
//

class EmployeeViewController: UIViewController, UIPickerViewDelegate {
    let application = UIApplication.sharedApplication().delegate as AppDelegate
    
    class Singleton {
        class var sharedInstance : Singleton {
            struct Static {
                static let instance : Singleton = Singleton()
            }
            return Static.instance
        }
    }

    let pickerView = UIPickerView()
    var businessResponse: Int = Int()
    
    var placetxtField: UITextField = CustomDesign.getNameTxtField
    var emailtxtField: UITextField = CustomDesign.getNameTxtField
    var passwtxtField: UITextField = CustomDesign.getNameTxtField
    var confirmsField: UITextField = CustomDesign.getNameTxtField
    var nameTextField: UITextField = CustomDesign.getNameTxtField
    var localTxtField: UITextField = CustomDesign.getNameTxtField
    
    let registerButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
    
    override func viewDidLoad() {
        let customDesign = CustomDesign()
        self.view.backgroundColor = customDesign.UIColorFromRGB(0xE4E4E4)
    
        super.viewDidLoad()
        
        nameTextField.frame = (CGRectMake(20, 70, self.view.bounds.width - 40, 40))
        nameTextField.placeholder = "Nombre"
        
        emailtxtField.frame = CGRectMake(20, 120, self.view.bounds.width - 40, 40)
        emailtxtField.placeholder = "Correo electrónico"
        
        passwtxtField.frame = CGRectMake(20, 170, self.view.bounds.width - 40, 40)
        passwtxtField.placeholder = "Contraseña"
        
        confirmsField.frame = CGRectMake(20, 220, self.view.bounds.width - 40, 40)
        confirmsField.placeholder = "Número telefónico"
        
        placetxtField.frame = CGRectMake(20, 270, self.view.bounds.width - 40, 40)
        placetxtField.placeholder = "Negocio"
        
        localTxtField.frame = (CGRectMake(20, 320, self.view.bounds.width - 40, 40))
        localTxtField.placeholder = "Localización"
        
        registerButton.frame = CGRectMake(20, 440, self.view.bounds.width - 40, 40)
        registerButton.tintColor = UIColor.whiteColor()
        registerButton.backgroundColor  = customDesign.UIColorFromRGB(0x34A3DB)
        registerButton.titleLabel?.font = UIFont.boldSystemFontOfSize(16.0)
        registerButton.setTitle("Registrarme", forState: UIControlState.Normal)
        registerButton.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview( emailtxtField)
        self.view.addSubview( placetxtField)
        self.view.addSubview( passwtxtField)
        self.view.addSubview( localTxtField)
        self.view.addSubview( confirmsField)
        self.view.addSubview( nameTextField)
        self.view.addSubview(registerButton)

        pickerView.delegate = self
        placetxtField.inputView = pickerView
        
        // Do any additional setup after loading the view.
        
        let postButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("dismiss"))
        self.navigationItem.leftBarButtonItem = postButton
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.navigationItem.title = "Empleado"
        self.tabBarController?.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.tabBarController?.navigationController?.navigationBar.backgroundColor = UIColor.whiteColor()
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    func dismiss() {
        let back = LoginViewController(nibName: nil, bundle: nil)
        self.presentViewController(back, animated: true, completion: nil)
    }
    
    func buttonAction(sender:UIButton!) {
        let request = HTTPrequests()
        
        let name  = nameTextField.text
        let email = emailtxtField.text
        let phone = confirmsField.text
        
        let password = passwtxtField.text
        let location = localTxtField.text
        let business = placetxtField.text
        
        let businessID = businessResponse
        
        request.registerRequest(email, name: name, phone: phone, passwd: password) {(str, error) -> Void in
            if let ok = str {request.authRequest(email, passwd: password) {(str, error) -> Void in
            if let ok = str {request.employeeReq(email, name: name, phone: phone, business: 1) {(str, error) -> Void in
            if let ok = str {request.getUserInfo(email, completion: { (str, error) -> Void in
            if let ok = str {
            dispatch_async(dispatch_get_main_queue(), {
                let views = ViewController()
                self.presentViewController(views, animated: true, completion: nil)
            })}})}}}}}
        }
    }
    // returns the number of 'columns' to display.
    func numberOfComponentsInPickerView(pickerView: UIPickerView!) -> Int{
        return 1
    }
    
    // returns the # of rows in each component..
    func pickerView(pickerView: UIPickerView!, numberOfRowsInComponent component: Int) -> Int {
        return DataManager.sharedManager.titles.count
    }
    
    func pickerView(pickerView: UIPickerView!, titleForRow row: Int, forComponent component: Int) -> String! {
        return DataManager.sharedManager.titles[row]["name"] as String
    }
    
    func pickerView(pickerView: UIPickerView!, didSelectRow row: Int, inComponent component: Int) {
        placetxtField.text = DataManager.sharedManager.titles[row]["name"] as String
        businessResponse = row + 1
    }
}