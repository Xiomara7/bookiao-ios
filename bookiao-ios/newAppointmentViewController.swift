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
    
    let pickerUsers = UIPickerView()
    let pickerServices = UIPickerView()
    let datePicker = UIDatePicker()
    let timePicker = UIDatePicker()
    let registroButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
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
        if self.application.userInfo["userType"] as String == "client" {
            employeeField.placeholder = "Empleado"
        }
        if self.application.userInfo["userType"] as String == "employee" {
            employeeField.placeholder = "Cliente"
        }
        
        registroButton.frame = CGRectMake(20, 300, self.view.bounds.width - 40, 40)
        registroButton.backgroundColor = customDesign.UIColorFromRGB(0x34A3DB)
        registroButton.tintColor = UIColor.whiteColor()
        registroButton.titleLabel?.font = UIFont.boldSystemFontOfSize(16.0)
        registroButton.setTitle("Crear Cita", forState: UIControlState.Normal)
        registroButton.addTarget(self, action: "buttonAction", forControlEvents: UIControlEvents.TouchUpInside)
        
        pickerUsers.delegate = self
        pickerServices.delegate = self
        dateTxtField.inputView = datePicker
        employeeField.inputView = pickerUsers
        serviceField.inputView = pickerServices
        timeTxtField.inputView = timePicker
        
        
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
        
        configureDatePicker()
        configureTimePicker()
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
    
    // A date formatter to format the `date` property of `datePicker`.
    lazy var dateFormatter: NSDateFormatter = {
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateStyle = .FullStyle

        return dateFormatter
        }()
    
    // A time formatter to format the `date` property of `timePicker`.
    lazy var timeFormatter: NSDateFormatter = {
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.timeStyle = .ShortStyle
        
        return dateFormatter
        }()
    
    // MARK: Configuration
    
    func configureDatePicker() {
        datePicker.datePickerMode = .Date
        
        // Set min/max date for the date picker.
        // As an example we will limit the date between now and 7 days from now.
        let now = NSDate()
        datePicker.minimumDate = now
        
        let currentCalendar = NSCalendar.currentCalendar()
        let dateComponents = NSDateComponents()
        
        datePicker.date = now
        datePicker.addTarget(self, action: "updateDatePickerLabel", forControlEvents: .ValueChanged)
    }
    
    func updateDatePickerLabel() {
        dateTxtField.text = dateFormatter.stringFromDate(datePicker.date)
    }
    
    func updateTimePickerLabel() {
        timeTxtField.text = timeFormatter.stringFromDate(timePicker.date)
    }
    
    func configureTimePicker() {
        timePicker.datePickerMode = .Time
        let now = NSTimeInterval()
        
        timePicker.addTarget(self, action: "updateTimePickerLabel", forControlEvents: .ValueChanged)
    }
    
    
    func buttonAction() {
        let request = HTTPrequests()
        if self.application.userInfo["userType"] as String == "client" {
            request.createAppointment([serviceField.text], employee:employeeField.text, client: self.application.userInfo["name"] as String, date: dateTxtField.text, theTime: timeTxtField.text)
        }
        if self.application.userInfo["userType"] as String == "employee" {
            request.createAppointment([serviceField.text], employee:self.application.userInfo["name"] as String, client:employeeField.text , date: dateTxtField.text, theTime: timeTxtField.text)
        }
        let views = ViewController(nibName: nil, bundle: nil)
        self.presentViewController(views, animated: true, completion: nil)
        
    }
    
    // PICKERS:
    
    // returns the number of 'columns' to display.
    func numberOfComponentsInPickerView(pickerView: UIPickerView!) -> Int{
        if pickerView == datePicker{
            return 3
        }
        if pickerView == timePicker{
            return 3
        }
        return 1
    }
    
    // returns the # of rows in each component..
    func pickerView(pickerView: UIPickerView!, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == pickerUsers {
            if self.application.userInfo["userType"] as String == "client" {
                return self.application.employees.count
            }
            if self.application.userInfo["userType"] as String == "employee" {
                return self.application.client.count
            }
        }
        if pickerView == pickerServices {
            return self.application.services.count
        }
        if pickerView == datePicker{
            return 10
        }
        return 10
    }
    
    func pickerView(pickerView: UIPickerView!, titleForRow row: Int, forComponent component: Int) -> String! {
        if pickerView == pickerUsers {
            if self.application.userInfo["userType"] as String == "client" {
                return self.application.employees[row]["name"] as String
            }
            if self.application.userInfo["userType"] as String == "employee" {
                return self.application.client[row]["name"] as String
            }
        }
        if pickerView == pickerServices {
            return self.application.services[row]["name"] as String
        }
        if pickerView == datePicker{
            return "hola"
        }
        return "None"
    }
    
    func pickerView(pickerView: UIPickerView!, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == pickerUsers {
            if self.application.userInfo["userType"] as String == "client" {
                employeeField.text = self.application.employees[row]["name"] as String
            }
            if self.application.userInfo["userType"] as String == "employee" {
                employeeField.text = self.application.client[row]["name"] as String
            }
        }
        if pickerView == pickerServices {
            serviceField.text = self.application.services[row]["name"] as String
        }
        if pickerView == datePicker{
            dateTxtField.text = "hola hola :P"
        }
    }
}