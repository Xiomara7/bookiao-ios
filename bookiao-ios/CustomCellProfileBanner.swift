//
//  CustomCell.swift
//  bookiao-ios
//
//  Created by Xiomara on 10/6/14.
//  Copyright (c) 2014 UPRRP. All rights reserved.
//

import UIKit

class CustomCellProfileBanner: UITableViewCell {
    
    struct Config {
        static let topPadding: CGFloat = 30.0
        static let bottomPadding: CGFloat = 40.0
        static let leftPadding: CGFloat = 150.0
        static let rightPadding: CGFloat = 40.0
    }
    
    let titleLabel: UILabel!
    let infoLabel: UILabel!
    let profilePic: UIImageView!
    let circleView: UIView!
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
        titleLabel.textColor = UIColor.whiteColor()
        
        contentView.addSubview(titleLabel)
        
        infoLabel = UILabel(frame: CGRectZero)
        infoLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        infoLabel.font = UIFont.systemFontOfSize(16.0)
        infoLabel.textAlignment = .Left
        infoLabel.textColor = UIColor.whiteColor()
        
        contentView.addSubview(infoLabel)
        
//        let picture = UIImage(named: "xio.png")
//        profilePic = UIImageView(image: picture)
//        
//        contentView.addSubview(profilePic)
        
        circleView = CircleView(frame: CGRectZero)
        contentView.addSubview(circleView)
        
    }
    
    
    override func updateConstraints() {
        //        titleLabel.autoPinEdge(.Top, toEdge: .Left, ofView: titleLabel, withOffset: 3.0)
        titleLabel.autoPinEdgeToSuperviewEdge(.Top, withInset: Config.topPadding + 60.0)
        titleLabel.autoPinEdgeToSuperviewEdge(.Left, withInset: Config.leftPadding)
        
        infoLabel.autoPinEdgeToSuperviewEdge(.Bottom, withInset: Config.bottomPadding)
        infoLabel.autoPinEdgeToSuperviewEdge(.Left, withInset: Config.leftPadding)
        
//        profilePic.autoPinEdgeToSuperviewEdge(.Top, withInset: Config.topPadding + 10.0)
//        profilePic.autoPinEdgeToSuperviewEdge(.Left, withInset: Config.rightPadding)
        
        circleView.autoPinEdgeToSuperviewEdge(.Top, withInset: Config.topPadding)
        circleView.autoPinEdgeToSuperviewEdge(.Left, withInset: Config.rightPadding)
        
        
        //        titleLabel.autoPinEdge(.Left, toEdge: .Right, ofView: titleLabel, withOffset: 2.0)
        //        priceLabel.autoPinEdge(.Right, toEdge: .Left, ofView: priceLabel, withOffset:-2.0)
        
        super.updateConstraints()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
