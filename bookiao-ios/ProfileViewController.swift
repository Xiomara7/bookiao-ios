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
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!){
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = customDesign.UIColorFromRGB(0xE4E4E4)
        super.viewDidLoad()
        
        var nametxtField: UITextField = UITextField()
        var nameApp = UITextField.appearance()
        nametxtField.frame = CGRectMake(20, 205, 275, 40)
        nametxtField.backgroundColor = UIColor.whiteColor()
        nametxtField.tintColor = UIColor.grayColor()
        nametxtField.font = UIFont.systemFontOfSize(14.0)
        nametxtField.textAlignment = .Center
        nametxtField.placeholder = "Nombre"
        
        var placetxtField: UITextField = UITextField()
        placetxtField.frame = CGRectMake(20, 260, 275, 40)
        placetxtField.backgroundColor = UIColor.whiteColor()
        placetxtField.tintColor = UIColor.grayColor()
        placetxtField.font = UIFont.systemFontOfSize(14.0)
        placetxtField.textAlignment = .Center
        placetxtField.placeholder = "Negocio"
        
        var positiontxtField: UITextField = UITextField()
        positiontxtField.frame = CGRectMake(20, 315, 275, 40)
        positiontxtField.backgroundColor = UIColor.whiteColor()
        positiontxtField.tintColor = UIColor.grayColor()
        positiontxtField.font = UIFont.systemFontOfSize(14.0)
        positiontxtField.textAlignment = .Center
        positiontxtField.placeholder = "Posición"
        
        var startTimetxtField: UITextField = UITextField()
        startTimetxtField.frame = CGRectMake(20, 370, 120, 40)
        startTimetxtField.backgroundColor = UIColor.whiteColor()
        startTimetxtField.tintColor = UIColor.grayColor()
        startTimetxtField.font = UIFont.systemFontOfSize(14.0)
        startTimetxtField.textAlignment = .Center
        startTimetxtField.placeholder = "Entrada"
        
        var endTimetxtField: UITextField = UITextField()
        endTimetxtField.frame = CGRectMake(175, 370, 120, 40)
        endTimetxtField.backgroundColor = UIColor.whiteColor()
        endTimetxtField.font = UIFont.systemFontOfSize(14.0)
        endTimetxtField.tintColor = UIColor.grayColor()
        endTimetxtField.textAlignment = .Center
        endTimetxtField.placeholder = "Salida"
        
        let registroButton   = UIButton.buttonWithType(UIButtonType.System) as UIButton
        registroButton.frame = CGRectMake(20, 440, 275, 45)
        registroButton.backgroundColor = customDesign.UIColorFromRGB(0x34A3DB)
        registroButton.tintColor = UIColor.whiteColor()
        registroButton.titleLabel?.font = UIFont.boldSystemFontOfSize(16.0)
        registroButton.setTitle("Grabar", forState: UIControlState.Normal)
        registroButton.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(nametxtField)
        self.view.addSubview(placetxtField)
        self.view.addSubview(positiontxtField)
        self.view.addSubview(startTimetxtField)
        self.view.addSubview(endTimetxtField)
        self.view.addSubview(registroButton)
    }
    
    func buttonAction(sender:UIButton!)
    {
        println("Button tapped")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}