//
//  CustomCell.swift
//  bookiao-ios
//
//  Created by Xiomara on 10/6/14.
//  Copyright (c) 2014 UPRRP. All rights reserved.
//

import UIKit

class CustomCellHistory: UITableViewCell {
    let custom = CustomDesign()
    struct Config {
        static let topPadding: CGFloat = 20.0
        static let bottomPadding: CGFloat = 30.0
        static let leftPadding: CGFloat = 30.0
        static let rightPadding: CGFloat = 30.0
    }
    
    let priceLabel: UILabel!
    let titleLabel: UILabel!
    let subtitleLabel: UILabel!
    let imageRight: UIImageView!
    
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
        titleLabel.font = UIFont.systemFontOfSize(16.0)
        titleLabel.textAlignment = .Left
        titleLabel.textColor = custom.UIColorFromRGB(0x545454)
        
        contentView.addSubview(titleLabel)
        
        subtitleLabel = UILabel(frame: CGRectZero)
        subtitleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        subtitleLabel.font = UIFont.systemFontOfSize(12.0)
        subtitleLabel.textAlignment = .Right
        subtitleLabel.textColor = custom.UIColorFromRGB(0x545454)
        
        contentView.addSubview(subtitleLabel)
        
        priceLabel = UILabel(frame: CGRectZero)
        priceLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        priceLabel.font = UIFont.systemFontOfSize(20.0)
        priceLabel.textAlignment = .Right
        priceLabel.textColor = custom.UIColorFromRGB(0x545454)
        
        contentView.addSubview(priceLabel)
        
//        let imageR = UIImage(named: "check.png")
//        imageRight = UIImageView(image: imageR)
//        contentView.addSubview(imageRight)
        
        
        
    }
    
    override func updateConstraints() {
        //        titleLabel.autoPinEdge(.Top, toEdge: .Left, ofView: titleLabel, withOffset: 3.0)
        titleLabel.autoPinEdgeToSuperviewEdge(.Top, withInset: Config.topPadding)
        titleLabel.autoPinEdgeToSuperviewEdge(.Left, withInset: Config.leftPadding)
        
        subtitleLabel.autoPinEdgeToSuperviewEdge(.Bottom, withInset: Config.bottomPadding)
        subtitleLabel.autoPinEdgeToSuperviewEdge(.Left, withInset: Config.leftPadding)
        
        priceLabel.autoPinEdgeToSuperviewEdge(.Top, withInset: Config.topPadding)
        priceLabel.autoPinEdgeToSuperviewEdge(.Right, withInset: Config.rightPadding)
        
//        imageRight.autoPinEdgeToSuperviewEdge(.Bottom, withInset: Config.bottomPadding - 30)
//        imageRight.autoPinEdgeToSuperviewEdge(.Right, withInset: 10)
        
//        titleLabel.autoPinEdge(.Left, toEdge: .Right, ofView: titleLabel, withOffset: 2.0)
//        priceLabel.autoPinEdge(.Right, toEdge: .Left, ofView: priceLabel, withOffset:-2.0)
        
        super.updateConstraints()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
