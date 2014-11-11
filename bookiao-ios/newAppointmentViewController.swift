//
//  newAppointmentViewController.swift
//  bookiao-ios
//
//  Created by Xiomara on 11/5/14.
//  Copyright (c) 2014 UPRRP. All rights reserved.
//

import Foundation

class newAppointmentViewController: UIViewController, UIPickerViewDelegate {
    var dateTxtField:  UITextField = UITextField()
    var timeTxtField:  UITextField = UITextField()
    var serviceField:  UITextField = UITextField()
    var employeeField: UITextField = UITextField()
    var employeeResponse: Int = Int()
    
    let pickerView = UIPickerView()
    let registroButton   = UIButton.buttonWithType(UIButtonType.System) as UIButton
    let application = UIApplication.sharedApplication().delegate as AppDelegate
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!){
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let customDesign = CustomDesign()
        self.view.backgroundColor = customDesign.UIColorFromRGB(0xE4E4E4)
        
        dateTxtField.frame = (CGRectMake(20, 70, self.view.bounds.width - 40, 40))
        dateTxtField.backgroundColor = UIColor.whiteColor()
        dateTxtField.tintColor = UIColor.grayColor()
        dateTxtField.font = UIFont.systemFontOfSize(14.0)
        dateTxtField.textAlignment = .Center
        dateTxtField.placeholder = "Fecha"
        
        timeTxtField.frame = CGRectMake(20, 120, self.view.bounds.width - 40, 40)
        timeTxtField.backgroundColor = UIColor.whiteColor()
        timeTxtField.tintColor = UIColor.grayColor()
        timeTxtField.font = UIFont.systemFontOfSize(14.0)
        timeTxtField.textAlignment = .Center
        timeTxtField.placeholder = "Hora"
        
        serviceField.frame = CGRectMake(20, 170, self.view.bounds.width - 40, 40)
        serviceField.backgroundColor = UIColor.whiteColor()
        serviceField.tintColor = UIColor.grayColor()
        serviceField.font = UIFont.systemFontOfSize(14.0)
        serviceField.textAlignment = .Center
        serviceField.placeholder = "Servicios"
        
        employeeField.frame = CGRectMake(20, 220, self.view.bounds.width - 40, 40)
        employeeField.backgroundColor = UIColor.whiteColor()
        employeeField.tintColor = UIColor.grayColor()
        employeeField.font = UIFont.systemFontOfSize(14.0)
        employeeField.textAlignment = .Center
        employeeField.placeholder = "Empleado"
        
        registroButton.frame = CGRectMake(20, 300, self.view.bounds.width - 40, 40)
        registroButton.backgroundColor = customDesign.UIColorFromRGB(0x34A3DB)
        registroButton.tintColor = UIColor.whiteColor()
        registroButton.titleLabel?.font = UIFont.boldSystemFontOfSize(16.0)
        registroButton.setTitle("Crear Cita", forState: UIControlState.Normal)
        registroButton.addTarget(self, action: "buttonAction", forControlEvents: UIControlEvents.TouchUpInside)
        
        pickerView.delegate = self
        employeeField.inputView = pickerView
        
        self.view.addSubview(dateTxtField)
        self.view.addSubview(serviceField)
        self.view.addSubview(timeTxtField)
        self.view.addSubview(employeeField)
        self.view.addSubview(registroButton)
        
        let navBar = UINavigationController(rootViewController: self)
        navBar.navigationBar.setBackgroundImage(UIImage(named: "menubar.png"), forBarMetrics: .Default)
        
        let postButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("dismiss"))
        
        self.navigationItem.leftBarButtonItem = postButton
        application.window.rootViewController = navBar
    }
    
    func dismiss() {
        let views = ViewController(nibName: nil, bundle: nil)
        self.presentViewController(views, animated: true, completion: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationItem.title = "Crear Citas"
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.backgroundColor = UIColor.whiteColor()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func buttonAction() {
        let request = HTTPrequests()
        let employeeID = employeeResponse
        
        request.createAppointment([1,2], employee:employeeField.text.toInt()!, client: 1, date: dateTxtField.text, theTime: timeTxtField.text)
        let views = ViewController(nibName: nil, bundle: nil)
        self.presentViewController(views, animated: true, completion: nil)
        
    }
    
    // returns the number of 'columns' to display.
    func numberOfComponentsInPickerView(pickerView: UIPickerView!) -> Int{
        return 1
    }
    
    // returns the # of rows in each component..
    func pickerView(pickerView: UIPickerView!, numberOfRowsInComponent component: Int) -> Int {
        return self.application.employees.count
    }
    
    func pickerView(pickerView: UIPickerView!, titleForRow row: Int, forComponent component: Int) -> String! {
        return self.application.employees[row]["name"] as String
    }
    
    func pickerView(pickerView: UIPickerView!, didSelectRow row: Int, inComponent component: Int) {
        employeeField.text = self.application.employees[row]["name"] as String
        employeeResponse = row + 1
    }
}