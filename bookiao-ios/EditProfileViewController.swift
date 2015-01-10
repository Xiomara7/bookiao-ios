//
//  EditProfileViewController.swift
//  bookiao-ios
//
//  Created by Xiomara on 11/15/14.
//  Copyright (c) 2014 UPRRP. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class EditProfileViewController: UIViewController, UIPickerViewDelegate {
    
    var customDesign = CustomDesign()
    var requests = HTTPrequests()
    var nametxtField: UITextField  = CustomDesign.getNameTxtField
    var emailtxtField: UITextField = CustomDesign.getNameTxtField
    var phonetxtField: UITextField = CustomDesign.getNameTxtField

    var businesstxtField: UITextField = CustomDesign.getNameTxtField
    var businessResponse: Int!
    
    let pickerView = UIPickerView()
    
    let registroButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
    let application = UIApplication.sharedApplication().delegate as AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = customDesign.UIColorFromRGB(0xE4E4E4)
        let application = UIApplication.sharedApplication().delegate as AppDelegate
        let ut = DataManager.sharedManager.userInfo
        
        nametxtField.frame = CGRectMake(20, 205, self.view.bounds.width - 40, 40)
        nametxtField.text  = ut["name"] as String!
        
        emailtxtField.frame = CGRectMake(20, 260, self.view.bounds.width - 40, 40)
        emailtxtField.text  = ut["email"] as String!
        
        phonetxtField.frame = CGRectMake(20, 315, self.view.bounds.width - 40, 40)
        phonetxtField.text  = ut["phone_number"] as String!
        
        if ut["userType"] as String == "employee" {
            businesstxtField.frame = CGRectMake(20, 370, self.view.bounds.width - 40, 40)
            businesstxtField.placeholder = "Negocio"
            pickerView.delegate = self
            businesstxtField.inputView = pickerView
            self.view.addSubview(businesstxtField)
            
        }
    
        registroButton.frame = CGRectMake(20, 440, self.view.bounds.width - 40, 40)
        registroButton.backgroundColor = customDesign.UIColorFromRGB(0x34A3DB)
        registroButton.tintColor = UIColor.whiteColor()
        registroButton.titleLabel?.font = UIFont.boldSystemFontOfSize(16.0)
        registroButton.setTitle("Grabar", forState: UIControlState.Normal)
        registroButton.addTarget(self, action: "dismiss", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(nametxtField)
        self.view.addSubview(emailtxtField)
        self.view.addSubview(phonetxtField)
        self.view.addSubview(registroButton)
        
        let postButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("dismiss"))
        self.navigationItem.leftBarButtonItem = postButton
    }

    func dismiss() {
        let ut = DataManager.sharedManager.userInfo
        if ut["userType"] as String == "employee" {
            requests.editProfile("employees", id: ut["id"] as Int!, nombre: nametxtField.text!, email: emailtxtField.text!, telefono: phonetxtField.text!, negocio: 1)
        }
        if ut["userType"] as String == "client" {
            requests.editProfile("clients", id: ut["id"] as Int!, nombre: nametxtField.text!, email: emailtxtField.text!, telefono: phonetxtField.text!, negocio: 1)
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.navigationItem.title = "Perfil"
        self.tabBarController?.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.tabBarController?.navigationController?.navigationBar.backgroundColor = UIColor.whiteColor()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        businesstxtField.text = DataManager.sharedManager.titles[row]["name"] as String
        businessResponse = row + 1
    }
}