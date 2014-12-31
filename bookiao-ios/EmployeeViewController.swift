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
    var passwordtxtField: UITextField = CustomDesign.getNameTxtField
    var confirmtxtField: UITextField = CustomDesign.getNameTxtField
    var nameTxtField: UITextField = CustomDesign.getNameTxtField
    var localTxtField: UITextField = CustomDesign.getNameTxtField
    
    let registroButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
    
    override func viewDidLoad() {
        let customDesign = CustomDesign()
        self.view.backgroundColor = customDesign.UIColorFromRGB(0xE4E4E4)
    
        super.viewDidLoad()
        
        nameTxtField.frame = (CGRectMake(20, 70, self.view.bounds.width - 40, 40))
        nameTxtField.placeholder = "Nombre"
        
        emailtxtField.frame = CGRectMake(20, 120, self.view.bounds.width - 40, 40)
        emailtxtField.placeholder = "Correo electrónico"
        
        passwordtxtField.frame = CGRectMake(20, 170, self.view.bounds.width - 40, 40)
        passwordtxtField.placeholder = "Contraseña"
        
        confirmtxtField.frame = CGRectMake(20, 220, self.view.bounds.width - 40, 40)
        confirmtxtField.placeholder = "Número telefónico"
        
        placetxtField.frame = CGRectMake(20, 270, self.view.bounds.width - 40, 40)
        placetxtField.placeholder = "Negocio"
        
        localTxtField.frame = (CGRectMake(20, 320, self.view.bounds.width - 40, 40))
        localTxtField.placeholder = "Localización"
        
        registroButton.frame = CGRectMake(20, 440, self.view.bounds.width - 40, 40)
        registroButton.backgroundColor = customDesign.UIColorFromRGB(0x34A3DB)
        registroButton.tintColor = UIColor.whiteColor()
        registroButton.titleLabel?.font = UIFont.boldSystemFontOfSize(16.0)
        registroButton.setTitle("Registrarme", forState: UIControlState.Normal)
        registroButton.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(emailtxtField)
        self.view.addSubview(placetxtField)
        self.view.addSubview(passwordtxtField)
        self.view.addSubview(localTxtField)
        self.view.addSubview(registroButton)
        self.view.addSubview(confirmtxtField)
        self.view.addSubview(nameTxtField)

        pickerView.delegate = self
        placetxtField.inputView = pickerView
        
        // Do any additional setup after loading the view.
        
        let postButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("dismiss"))
        self.navigationItem.leftBarButtonItem = postButton
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        let name  = nameTxtField.text
        let email = emailtxtField.text
        let phone = confirmtxtField.text
        let password = passwordtxtField.text
        let location = localTxtField.text
        let business = placetxtField.text
        let businessID = businessResponse

        request.getUserInfo(email, completion: { (str, error) -> Void in
            println("holita")
        })
        request.registerRequest(email, name: name, phone: phone, passwd: password, loc: location, man: "", bus: business, bID: businessID,  user: "empleado")
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