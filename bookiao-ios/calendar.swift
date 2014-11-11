//
//  calendar.swift
//  bookiao-ios
//
//  Created by Xiomara on 11/11/14.
//  Copyright (c) 2014 UPRRP. All rights reserved.
//

import Foundation

class customCalendar: UICollectionView {
        
    struct Config {
        static let topPadding: CGFloat = 30.0
        static let bottomPadding: CGFloat = 30.0
        static let leftPadding: CGFloat = 30.0
        static let rightPadding: CGFloat = 30.0
    }
        
    let month: UILabel!
    let weekDay: UILabel!
    let eachDay: UILabel!
        
    class var defaultHeight: CGFloat {
        return 84.0
    }
        
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    init(reuseIdentifier: String!) {
        super.init()
            
        self.opaque = true
        
        month = UILabel(frame: CGRectZero)
        month.setTranslatesAutoresizingMaskIntoConstraints(false)
        month.font = UIFont.systemFontOfSize(18.0)
        month.textColor = UIColor.blackColor()
            
//        contentView.addSubview(month)
        
        weekDay = UILabel(frame: CGRectZero)
        weekDay.setTranslatesAutoresizingMaskIntoConstraints(false)
        weekDay.font = UIFont.systemFontOfSize(12.0)
        weekDay.textColor = UIColor.grayColor()
        
        eachDay = UILabel(frame: CGRectZero)
        eachDay.setTranslatesAutoresizingMaskIntoConstraints(false)
        eachDay.font = UIFont.systemFontOfSize(20.0)
        eachDay.textColor = UIColor.blackColor()
        
        
//    override func updateConstraints() {
//        titleLabel.autoPinEdgeToSuperviewEdge(.Top, withInset: Config.topPadding)
//        titleLabel.autoPinEdgeToSuperviewEdge(.Left, withInset: Config.leftPadding)
//            
//        subtitleLabel.autoPinEdgeToSuperviewEdge(.Bottom, withInset: Config.bottomPadding)
//        subtitleLabel.autoPinEdgeToSuperviewEdge(.Left, withInset: Config.leftPadding)
//            
//        priceLabel.autoPinEdgeToSuperviewEdge(.Top, withInset: Config.topPadding + 10.0)
//        priceLabel.autoPinEdgeToSuperviewEdge(.Right, withInset: Config.rightPadding)
//
//            
//        super.updateConstraints()
//    }
        
//    override func setSelected(selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//    }
    }
}