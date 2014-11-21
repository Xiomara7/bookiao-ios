//
//  CustomDesign.swift
//  bookiao-ios
//
//  Created by Xiomara on 10/7/14.
//  Copyright (c) 2014 UPRRP. All rights reserved.
//

import Foundation

class CustomDesign {
 
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    class var getNameTxtField: UITextField {
        
        var nameTxtField: UITextField = UITextField()
        nameTxtField.frame = CGRectZero
        nameTxtField.backgroundColor = UIColor.whiteColor()
        nameTxtField.tintColor = UIColor.grayColor()
        nameTxtField.font = UIFont.systemFontOfSize(14.0)
        nameTxtField.textAlignment = .Center
        
        return nameTxtField
        
    }
    
    class var getNameLabel: UILabel {
        
        var subscription: UILabel = UILabel()
        subscription.font = UIFont.boldSystemFontOfSize(18.0)
        subscription.textAlignment = .Center
        
        return subscription
    }
    
    class var getProfileLabel: UILabel {
        
        var nameLabel: UILabel = UILabel()
        nameLabel.backgroundColor = UIColor.whiteColor()
        nameLabel.tintColor = UIColor.grayColor()
        nameLabel.font = UIFont.systemFontOfSize(14.0)
        nameLabel.textAlignment = .Center
        
        return nameLabel
    }

}

