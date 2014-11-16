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
    
        var nametxtField: UILabel = UILabel()
        var placetxtField: UILabel = UILabel()
        var positiontxtField: UILabel = UILabel()
        var startTimetxtField: UILabel = UILabel()
        var endTimetxtField: UILabel = UILabel()
        let registroButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
        let application = UIApplication.sharedApplication().delegate as AppDelegate
    
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
        
        var nameApp = UILabel.appearance()
        nametxtField.frame = CGRectMake(20, 205, self.view.bounds.width - 40, 40)
        nametxtField.backgroundColor = UIColor.whiteColor()
        nametxtField.tintColor = UIColor.grayColor()
        nametxtField.font = UIFont.systemFontOfSize(14.0)
        nametxtField.textAlignment = .Center
        nametxtField.text = self.application.userInfo["name"] as? String
        
        placetxtField.frame = CGRectMake(20, 260, self.view.bounds.width - 40, 40)
        placetxtField.backgroundColor = UIColor.whiteColor()
        placetxtField.tintColor = UIColor.grayColor()
        placetxtField.font = UIFont.systemFontOfSize(14.0)
        placetxtField.textAlignment = .Center
        placetxtField.text = "Negocio"
        
        positiontxtField.frame = CGRectMake(20, 315, self.view.bounds.width - 40, 40)
        positiontxtField.backgroundColor = UIColor.whiteColor()
        positiontxtField.tintColor = UIColor.grayColor()
        positiontxtField.font = UIFont.systemFontOfSize(14.0)
        positiontxtField.textAlignment = .Center
        positiontxtField.text = self.application.userInfo["userType"] as? String
        
        startTimetxtField.frame = CGRectMake(20, 370, self.view.bounds.width / 2 - 30 , 40)
        startTimetxtField.backgroundColor = UIColor.whiteColor()
        startTimetxtField.tintColor = UIColor.grayColor()
        startTimetxtField.font = UIFont.systemFontOfSize(14.0)
        startTimetxtField.textAlignment = .Center
        startTimetxtField.text = "Entrada"
        
        endTimetxtField.frame = CGRectMake(self.view.bounds.width / 2 + 10, 370, self.view.bounds.width / 2 - 30 , 40)
        endTimetxtField.backgroundColor = UIColor.whiteColor()
        endTimetxtField.font = UIFont.systemFontOfSize(14.0)
        endTimetxtField.tintColor = UIColor.grayColor()
        endTimetxtField.textAlignment = .Center
        endTimetxtField.text = "Salida"
        
        registroButton.frame = CGRectMake(20, 440, self.view.bounds.width - 40, 40)
        registroButton.backgroundColor = customDesign.UIColorFromRGB(0x34A3DB)
        registroButton.tintColor = UIColor.whiteColor()
        registroButton.titleLabel?.font = UIFont.boldSystemFontOfSize(16.0)
        registroButton.setTitle("Editar", forState: UIControlState.Normal)
        registroButton.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(nametxtField)
        self.view.addSubview(placetxtField)
        self.view.addSubview(positiontxtField)
        self.view.addSubview(startTimetxtField)
        self.view.addSubview(endTimetxtField)
        self.view.addSubview(registroButton)
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