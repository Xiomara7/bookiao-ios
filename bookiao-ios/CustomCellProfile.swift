//
//  CustomCell.swift
//  bookiao-ios
//
//  Created by Xiomara on 10/6/14.
//  Copyright (c) 2014 UPRRP. All rights reserved.
//

import UIKit

class CustomCellProfile: UITableViewCell {
    
    struct Config {
        static let topPadding: CGFloat = 30.0
        static let bottomPadding: CGFloat = 30.0
        static let leftPadding: CGFloat = 20.0
        static let rightPadding: CGFloat = 30.0
    }
    
    let titleLabel: UILabel!
    let infoField: UITextField!
    
    class var defaultHeight: CGFloat {
    return 84.0
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(reuseIdentifier: String!) {
        super.init(style: .Default, reuseIdentifier: reuseIdentifier)
        
        self.opaque = true
        
        titleLabel = UILabel(frame: CGRectZero)
        titleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        titleLabel.font = UIFont.systemFontOfSize(14.0)
        titleLabel.textAlignment = .Left
        titleLabel.textColor = UIColor.blackColor()
        
        contentView.addSubview(titleLabel)
        
        infoField = UITextField(frame: CGRectZero)
        infoField.setTranslatesAutoresizingMaskIntoConstraints(false)
        infoField.font = UIFont.systemFontOfSize(14.0)
        infoField.textAlignment = .Left
        infoField.textColor = UIColor.blackColor()
        
        contentView.addSubview(infoField)
        
    }
    
    override func updateConstraints() {
        //        titleLabel.autoPinEdge(.Top, toEdge: .Left, ofView: titleLabel, withOffset: 3.0)
        titleLabel.autoPinEdgeToSuperviewEdge(.Top, withInset: Config.topPadding - 15.0)
        titleLabel.autoPinEdgeToSuperviewEdge(.Left, withInset: Config.leftPadding)
        
        infoField.autoPinEdgeToSuperviewEdge(.Bottom, withInset: Config.bottomPadding - 25.0)
        infoField.autoPinEdgeToSuperviewEdge(.Left, withInset: Config.leftPadding)
        
        
        
        //        titleLabel.autoPinEdge(.Left, toEdge: .Right, ofView: titleLabel, withOffset: 2.0)
        //        priceLabel.autoPinEdge(.Right, toEdge: .Left, ofView: priceLabel, withOffset:-2.0)
        
        super.updateConstraints()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
