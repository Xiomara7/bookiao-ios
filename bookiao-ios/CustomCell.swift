//
//  CustomCell.swift
//  bookiao-ios
//
//  Created by Xiomara on 10/6/14.
//  Copyright (c) 2014 UPRRP. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    let custom = CustomDesign()
    struct Config {
        static let topPadding: CGFloat = 20.0
        static let bottomPadding: CGFloat = 50.0
        static let leftPadding: CGFloat = 30.0
        static let rightPadding: CGFloat = 30.0
    }
    
    let priceLabel:  UILabel!
    let titleLabel:  UILabel!
    let phoneLabel:  UILabel!
    let stitleLabel: UILabel!
    let sTitle: UILabel!
    let status: UILabel!
    let postButton: UIButton! = UIButton.buttonWithType(UIButtonType.System) as UIButton
    
    class var defaultHeight: CGFloat {
        return 150.0
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(reuseIdentifier: String!) {
        super.init(style: .Default, reuseIdentifier: reuseIdentifier)
        
        self.opaque = true
        
        titleLabel = UILabel(frame: CGRectZero)
        titleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        titleLabel.font = UIFont.systemFontOfSize(16.0)
        titleLabel.textAlignment = .Left
        titleLabel.textColor = custom.UIColorFromRGB(0x545454)
        
        contentView.addSubview(titleLabel)
        
        stitleLabel = UILabel(frame: CGRectZero)
        stitleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        stitleLabel.font = UIFont.systemFontOfSize(12.0)
        stitleLabel.textAlignment = .Right
        stitleLabel.textColor = custom.UIColorFromRGB(0x545454)
        
        contentView.addSubview(stitleLabel)
        
        priceLabel = UILabel(frame: CGRectZero)
        priceLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        priceLabel.font = UIFont.systemFontOfSize(12.0)
        priceLabel.textAlignment = .Left
        priceLabel.textColor = custom.UIColorFromRGB(0x545454)
        
        contentView.addSubview(priceLabel)
        
        phoneLabel = UILabel(frame: CGRectZero)
        phoneLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        phoneLabel.font = UIFont.systemFontOfSize(12.0)
        phoneLabel.textAlignment = .Left
        phoneLabel.textColor = custom.UIColorFromRGB(0x545454)
        
        contentView.addSubview(phoneLabel)
        
        postButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        contentView.addSubview(postButton)
        
        sTitle = UILabel(frame: CGRectZero)
        sTitle.setTranslatesAutoresizingMaskIntoConstraints(false)
        sTitle.font = UIFont.boldSystemFontOfSize(18.0)
        sTitle.textAlignment = .Center
        sTitle.textColor = custom.UIColorFromRGB(0x545454)
        
        contentView.addSubview(sTitle)
        
        status = UILabel(frame: CGRectZero)
        status.setTranslatesAutoresizingMaskIntoConstraints(false)
        status.font = UIFont.systemFontOfSize(12.0)
        status.textAlignment = .Center
        
        contentView.addSubview(status)
        
    }
    
    override func updateConstraints() {

        titleLabel.autoPinEdgeToSuperviewEdge(.Top, withInset: Config.topPadding)
        titleLabel.autoPinEdgeToSuperviewEdge(.Left, withInset: Config.leftPadding)
        
        phoneLabel.autoPinEdgeToSuperviewEdge(.Top, withInset: Config.topPadding + 20.0)
        phoneLabel.autoPinEdgeToSuperviewEdge(.Left, withInset: Config.leftPadding)
        
        stitleLabel.autoPinEdgeToSuperviewEdge(.Bottom, withInset: Config.bottomPadding)
        stitleLabel.autoPinEdgeToSuperviewEdge(.Left, withInset: Config.leftPadding)
        
        priceLabel.autoPinEdgeToSuperviewEdge(.Bottom, withInset: Config.bottomPadding - 15.0)
        priceLabel.autoPinEdgeToSuperviewEdge(.Left, withInset: Config.leftPadding)
        
        sTitle.autoPinEdgeToSuperviewEdge(.Top, withInset: Config.topPadding)
        sTitle.autoPinEdgeToSuperviewEdge(.Left, withInset: self.bounds.width / 2 - 40.0)
        
        status.autoPinEdgeToSuperviewEdge(.Top, withInset: Config.topPadding + 20.0)
        status.autoPinEdgeToSuperviewEdge(.Left, withInset: self.bounds.width / 2 - 100.0)
        
        postButton.autoPinEdgeToSuperviewEdge(.Bottom, withInset: Config.bottomPadding - 15.0)
        postButton.autoPinEdgeToSuperviewEdge(.Left, withInset: self.bounds.width / 2 - 30.0)
        
        super.updateConstraints()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
