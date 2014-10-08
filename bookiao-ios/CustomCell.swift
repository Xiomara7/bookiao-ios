//
//  CustomCell.swift
//  bookiao-ios
//
//  Created by Xiomara on 10/6/14.
//  Copyright (c) 2014 UPRRP. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    
    struct Config {
        static let topPadding: CGFloat = 30.0
        static let bottomPadding: CGFloat = 30.0
        static let leftPadding: CGFloat = 30.0
        static let rightPadding: CGFloat = 30.0
    }
    
    let priceLabel: UILabel!
    let titleLabel: UILabel!
    let subtitleLabel: UILabel!

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
        titleLabel.font = UIFont.systemFontOfSize(18.0)
        titleLabel.textAlignment = .Left
        titleLabel.textColor = UIColor.blackColor()
        
        contentView.addSubview(titleLabel)
        
        subtitleLabel = UILabel(frame: CGRectZero)
        subtitleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        subtitleLabel.font = UIFont.systemFontOfSize(12.0)
        subtitleLabel.textAlignment = .Right
        subtitleLabel.textColor = UIColor.grayColor()
        
        contentView.addSubview(subtitleLabel)
        
        priceLabel = UILabel(frame: CGRectZero)
        priceLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        priceLabel.font = UIFont.systemFontOfSize(20.0)
        priceLabel.textAlignment = .Right
        priceLabel.textColor = UIColor.blackColor()
        
        contentView.addSubview(priceLabel)
        
        
        
    }
    
    override func updateConstraints() {
//        titleLabel.autoPinEdge(.Top, toEdge: .Left, ofView: titleLabel, withOffset: 3.0)
        titleLabel.autoPinEdgeToSuperviewEdge(.Top, withInset: Config.topPadding)
        titleLabel.autoPinEdgeToSuperviewEdge(.Left, withInset: Config.leftPadding)
        
        subtitleLabel.autoPinEdgeToSuperviewEdge(.Bottom, withInset: Config.bottomPadding)
        subtitleLabel.autoPinEdgeToSuperviewEdge(.Left, withInset: Config.leftPadding)
        
        priceLabel.autoPinEdgeToSuperviewEdge(.Top, withInset: Config.topPadding + 10.0)
        priceLabel.autoPinEdgeToSuperviewEdge(.Right, withInset: Config.rightPadding)
        
        
//        titleLabel.autoPinEdge(.Left, toEdge: .Right, ofView: titleLabel, withOffset: 2.0)
//        priceLabel.autoPinEdge(.Right, toEdge: .Left, ofView: priceLabel, withOffset:-2.0)
        
        super.updateConstraints()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
