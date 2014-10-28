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
}

