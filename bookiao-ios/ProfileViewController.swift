//
//  ProfileViewController.swift
//  bookiao-ios
//
//  Created by Xiomara on 10/17/14.
//  Copyright (c) 2014 UPRRP. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ProfileViewController: UIViewController {
    
    var customDesign = CustomDesign()
    
        var nameLabel:  UILabel = CustomDesign.getProfileLabel
        var emailLabel: UILabel = CustomDesign.getProfileLabel
        var phoneLabel: UILabel = CustomDesign.getProfileLabel
    
        let rButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
        let application = UIApplication.sharedApplication().delegate as AppDelegate
    
    override func viewDidLoad() {
        
        self.view.backgroundColor = customDesign.UIColorFromRGB(0xE4E4E4)
        let application = UIApplication.sharedApplication().delegate as AppDelegate
        super.viewDidLoad()
        
        let userinfo = DataManager.sharedManager.userInfo
        
        nameLabel.frame = CGRectMake(20, 205, self.view.bounds.width - 40, 40)
        nameLabel.text  = userinfo["name"] as String!
        
        emailLabel.frame = CGRectMake(20, 260, self.view.bounds.width - 40, 40)
        emailLabel.text  = userinfo["email"] as String!
        
        phoneLabel.frame = CGRectMake(20, 315, self.view.bounds.width - 40, 40)
        phoneLabel.text  = userinfo["phone_number"] as String!
        
        rButton.frame = CGRectMake(20, 440, self.view.bounds.width - 40, 40)
        rButton.backgroundColor = customDesign.UIColorFromRGB(0x34A3DB)
        rButton.tintColor = UIColor.whiteColor()
        rButton.titleLabel?.font = UIFont.boldSystemFontOfSize(16.0)
        rButton.setTitle("Editar", forState: UIControlState.Normal)
        rButton.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(nameLabel)
        self.view.addSubview(phoneLabel)
        self.view.addSubview(emailLabel)
        self.view.addSubview(rButton)
    }
    
    func buttonAction(sender:UIButton!){
        println("Button tapped")
        let edit = EditProfileViewController(nibName: nil, bundle: nil)
        self.presentViewController(edit, animated: true, completion: nil)

        
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