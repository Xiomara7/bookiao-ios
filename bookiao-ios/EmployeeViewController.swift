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
    var placetxtField: UITextField = UITextField()
    var emailtxtField: UITextField = UITextField()
    var passwordtxtField: UITextField = UITextField()
    var confirmtxtField: UITextField = UITextField()
    var nameTxtField: UITextField = UITextField()
    var localTxtField: UITextField = UITextField()
    var startTimetxtField: UITextField = UITextField()
    var endTimetxtField: UITextField = UITextField()
    let registroButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
    
    override func viewDidLoad() {
        let customDesign = CustomDesign()
        self.view.backgroundColor = customDesign.UIColorFromRGB(0xE4E4E4)
    
        super.viewDidLoad()
        
        nameTxtField.frame = (CGRectMake(20, 70, self.view.bounds.width - 40, 40))
        nameTxtField.backgroundColor = UIColor.whiteColor()
        nameTxtField.tintColor = UIColor.grayColor()
        nameTxtField.font = UIFont.systemFontOfSize(14.0)
        nameTxtField.textAlignment = .Center
        nameTxtField.placeholder = "Nombre"
        
        emailtxtField.frame = CGRectMake(20, 120, self.view.bounds.width - 40, 40)
        emailtxtField.backgroundColor = UIColor.whiteColor()
        emailtxtField.tintColor = UIColor.grayColor()
        emailtxtField.font = UIFont.systemFontOfSize(14.0)
        emailtxtField.textAlignment = .Center
        emailtxtField.placeholder = "Correo electrónico"
        
        passwordtxtField.frame = CGRectMake(20, 170, self.view.bounds.width - 40, 40)
        passwordtxtField.backgroundColor = UIColor.whiteColor()
        passwordtxtField.tintColor = UIColor.grayColor()
        passwordtxtField.font = UIFont.systemFontOfSize(14.0)
        passwordtxtField.textAlignment = .Center
        passwordtxtField.placeholder = "Contraseña"
        
        confirmtxtField.frame = CGRectMake(20, 220, self.view.bounds.width - 40, 40)
        confirmtxtField.backgroundColor = UIColor.whiteColor()
        confirmtxtField.tintColor = UIColor.grayColor()
        confirmtxtField.font = UIFont.systemFontOfSize(14.0)
        confirmtxtField.textAlignment = .Center
        confirmtxtField.placeholder = "Número telefónico"
        
        placetxtField.frame = CGRectMake(20, 270, self.view.bounds.width - 40, 40)
        placetxtField.backgroundColor = UIColor.whiteColor()
        placetxtField.tintColor = UIColor.grayColor()
        placetxtField.font = UIFont.systemFontOfSize(14.0)
        placetxtField.textAlignment = .Center
        placetxtField.placeholder = "Negocio"
        
        localTxtField.frame = (CGRectMake(20, 320, self.view.bounds.width - 40, 40))
        localTxtField.backgroundColor  = UIColor.whiteColor()
        localTxtField.tintColor = UIColor.blackColor()
        localTxtField.font = UIFont.systemFontOfSize(14.0)
        localTxtField.textAlignment = .Center
        localTxtField.placeholder = "Localización"
        
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
        
        registroButton.frame = CGRectMake(20, 440, self.view.bounds.width - 40, 40)
        registroButton.backgroundColor = customDesign.UIColorFromRGB(0x34A3DB)
        registroButton.tintColor = UIColor.whiteColor()
        registroButton.titleLabel?.font = UIFont.boldSystemFontOfSize(16.0)
        registroButton.setTitle("Registrarme", forState: UIControlState.Normal)
        registroButton.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(emailtxtField)
        self.view.addSubview(placetxtField)
        self.view.addSubview(passwordtxtField)
        self.view.addSubview(startTimetxtField)
        self.view.addSubview(localTxtField)
        self.view.addSubview(endTimetxtField)
        self.view.addSubview(registroButton)
        self.view.addSubview(confirmtxtField)
        self.view.addSubview(nameTxtField)

        pickerView.delegate = self
        placetxtField.inputView = pickerView
        
        // Do any additional setup after loading the view.
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.navigationItem.title = "Empleado"
        self.tabBarController?.navigationController?.navigationBar.tintColor = UIColor.blackColor()
        self.tabBarController?.navigationController?.navigationBar.backgroundColor = UIColor.blackColor()
        
    }
    
    func buttonAction(sender:UIButton!) {
        let request = HTTPrequests()
        
        let name  = nameTxtField.text
        let email = emailtxtField.text
        let phone = confirmtxtField.text
        let password = passwordtxtField.text
        let location = localTxtField.text
        let manager  = ""
        let business = placetxtField.text
        let businessID = businessResponse
        let usuario  = "empleado"
        
        request.registerRequest(email, name: name, phone: phone, password: password, location: location, manager: manager, business: business, bID: businessID,  usuario: usuario)
        let views = ViewController(nibName: nil, bundle: nil)
        self.presentViewController(views, animated: true, completion: nil)
    }
    // returns the number of 'columns' to display.
    func numberOfComponentsInPickerView(pickerView: UIPickerView!) -> Int{
        return 1
    }
    
    // returns the # of rows in each component..
    func pickerView(pickerView: UIPickerView!, numberOfRowsInComponent component: Int) -> Int {
        return self.application.Bcount
    }
    
    func pickerView(pickerView: UIPickerView!, titleForRow row: Int, forComponent component: Int) -> String! {
        return self.application.titles[row]["name"] as String
    }
    
    func pickerView(pickerView: UIPickerView!, didSelectRow row: Int, inComponent component: Int) {
        placetxtField.text = self.application.titles[row]["name"] as String
        businessResponse = row + 1
    }
}