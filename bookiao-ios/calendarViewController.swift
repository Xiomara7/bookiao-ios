//
//  newAppointmentViewController.swift
//  bookiao-ios
//
//  Created by Xiomara on 11/5/14.
//  Copyright (c) 2014 UPRRP. All rights reserved.
//

import Foundation

class calendarViewController: UIViewController, UIPickerViewDelegate {
    var dateTxtField: UITextField = CustomDesign.getNameTxtField
    
    let datePicker = UIDatePicker()

    let registroButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
    let application = UIApplication.sharedApplication().delegate as AppDelegate
    
    let views = AppointmentsViewController()
    let requests = HTTPrequests()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let customDesign = CustomDesign()
        self.view.backgroundColor = customDesign.UIColorFromRGB(0xE4E4E4)
        
        dateTxtField.frame = (CGRectMake(20, 70, self.view.bounds.width - 40, 40))
        dateTxtField.placeholder = "Fecha"
        
        registroButton.frame = CGRectMake(20, 300, self.view.bounds.width - 40, 40)
        registroButton.backgroundColor = customDesign.UIColorFromRGB(0x34A3DB)
        registroButton.tintColor = UIColor.whiteColor()
        registroButton.titleLabel?.font = UIFont.boldSystemFontOfSize(16.0)
        registroButton.setTitle("Ver Citas de este día", forState: UIControlState.Normal)
        registroButton.addTarget(self, action: "buttonAction", forControlEvents: UIControlEvents.TouchUpInside)
        
        dateTxtField.inputView = datePicker
        
        self.view.addSubview(dateTxtField)
        self.view.addSubview(registroButton)
        
        let navBar = UINavigationController(rootViewController: self)
        navBar.navigationBar.setBackgroundImage(UIImage(named: "menubar.png"), forBarMetrics: .Default)
        
        let postButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("dismiss"))
        
        self.navigationItem.leftBarButtonItem = postButton
        application.window.rootViewController = navBar
        
        configureDatePicker()
    }
    
    func dismiss() {
        let views = ViewController(nibName: nil, bundle: nil)
        self.presentViewController(views, animated: true, completion: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationItem.title = "Ver Citas"
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
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter
        }()
    
    lazy var dateFormatterLabel: NSDateFormatter = {
        let dateFormatterLabel = NSDateFormatter()
        
        dateFormatterLabel.dateStyle = .MediumStyle
        
        return dateFormatterLabel
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
    
    func buttonAction() {
        self.navigationItem.title = dateFormatter.stringFromDate(datePicker.date)
        DataManager.sharedManager.date = dateFormatter.stringFromDate(datePicker.date)
        DataManager.sharedManager.dateLabel = dateFormatterLabel.stringFromDate(datePicker.date)
        
        let ut = DataManager.sharedManager.userInfo["userType"] as String!
        let id = DataManager.sharedManager.userInfo["id"] as Int
        if ut == "client" {
            requests.getClientAppointmentsPerDay(id, date: DataManager.sharedManager.date)
        }
        if ut == "employee" {
            requests.getEmployeeAppointmentsPerDay(id, date: DataManager.sharedManager.date)
        }
    }
    
    // PICKERS:
    
    // returns the number of 'columns' to display.
    func numberOfComponentsInPickerView(pickerView: UIPickerView!) -> Int{
        return 3
    }
    
    // returns the # of rows in each component..
    func pickerView(pickerView: UIPickerView!, numberOfRowsInComponent component: Int) -> Int {
        return 10
    }
    
    func pickerView(pickerView: UIPickerView!, titleForRow row: Int, forComponent component: Int) -> String! {
        
        if pickerView == datePicker{
        }
        return "None"
    }
    
    func pickerView(pickerView: UIPickerView!, didSelectRow row: Int, inComponent component: Int) {

        if pickerView == datePicker{
        }
    }
}