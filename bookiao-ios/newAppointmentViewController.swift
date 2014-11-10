//
//  newAppointmentViewController.swift
//  bookiao-ios
//
//  Created by Xiomara on 11/5/14.
//  Copyright (c) 2014 UPRRP. All rights reserved.
//

import Foundation

class newAppointmentViewController: UIViewController {
    var dateTxtField:  UITextField = UITextField()
    var timeTxtField:  UITextField = UITextField()
    var serviceField:  UITextField = UITextField()
    var employeeField: UITextField = UITextField()
    
    let registroButton   = UIButton.buttonWithType(UIButtonType.System) as UIButton
    
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
        
        registroButton.frame = CGRectMake(20, 440, self.view.bounds.width - 40, 40)
        registroButton.backgroundColor = customDesign.UIColorFromRGB(0x34A3DB)
        registroButton.tintColor = UIColor.whiteColor()
        registroButton.titleLabel?.font = UIFont.boldSystemFontOfSize(16.0)
        registroButton.setTitle("Crear Cita", forState: UIControlState.Normal)
        registroButton.addTarget(self, action: "buttonAction", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(dateTxtField)
        self.view.addSubview(serviceField)
        self.view.addSubview(timeTxtField)
        self.view.addSubview(employeeField)
        self.view.addSubview(registroButton)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func buttonAction() {
        let request = HTTPrequests()
        request.createAppointment([1,2], employee:employeeField.text.toInt()!, client: 1, date: dateTxtField.text, theTime: timeTxtField.text)
        
    }
}