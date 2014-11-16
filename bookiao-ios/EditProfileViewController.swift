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

class EditProfileViewController: UIViewController {
    
    var customDesign = CustomDesign()
    var nametxtField: UITextField = UITextField()
    var emailtxtField: UITextField = UITextField()
    var phonetxtField: UITextField = UITextField()
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!){
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = customDesign.UIColorFromRGB(0xE4E4E4)
        let application = UIApplication.sharedApplication().delegate as AppDelegate
        super.viewDidLoad()
        
        var nameApp = UITextField.appearance()
        nametxtField.frame = CGRectMake(20, 205, self.view.bounds.width - 40, 40)
        nametxtField.backgroundColor = UIColor.whiteColor()
        nametxtField.tintColor = UIColor.grayColor()
        nametxtField.font = UIFont.systemFontOfSize(14.0)
        nametxtField.textAlignment = .Center
        nametxtField.placeholder = "Nombre"
        
        emailtxtField.frame = CGRectMake(20, 260, self.view.bounds.width - 40, 40)
        emailtxtField.backgroundColor = UIColor.whiteColor()
        emailtxtField.tintColor = .grayColor()
        emailtxtField.font = .systemFontOfSize(14.0)
        emailtxtField.textAlignment = .Center
        emailtxtField.placeholder = "Email"
        
        phonetxtField.frame = CGRectMake(20, 315, self.view.bounds.width - 40, 40)
        phonetxtField.backgroundColor = UIColor.whiteColor()
        phonetxtField.tintColor = UIColor.grayColor()
        phonetxtField.font = UIFont.systemFontOfSize(14.0)
        phonetxtField.textAlignment = .Center
        phonetxtField.placeholder = "Teléfono"
        
        let registroButton   = UIButton.buttonWithType(UIButtonType.System) as UIButton
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
}