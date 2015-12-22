//
//  CreateQuestCell3.swift
//  CourseDemo
//
//  Created by hjliu on 2015/12/21.
//  Copyright © 2015年 hjliu. All rights reserved.
//

import UIKit
import NYSegmentedControl

class CreateQuestCell3: UITableViewCell {
    
    var contentControl = NYSegmentedControl()
    
    var timeMapKeys = [String()]
    var timeMapValues = [Double]()
    
    var changeIndex:(Int->())?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentControl.titleTextColor = UIColor.whiteColor()
        contentControl.selectedTitleTextColor = UIColor.whiteColor()
        //        Timetext.drawsGradientBackground = true
        contentControl.segmentIndicatorInset = 2.0
        //        Timetext.drawsSegmentIndicatorGradientBackground = true
        contentControl.backgroundColor = UIColor.lightGrayColor()
        contentControl.segmentIndicatorAnimationDuration = 0.3
        contentControl.segmentIndicatorGradientTopColor = UIColor(red: 0.3, green: 0.5, blue: 0.88, alpha: 1)
        contentControl.segmentIndicatorGradientBottomColor = UIColor(red: 0.2, green: 0.35, blue: 0.75, alpha: 1)
        contentControl.addTarget(self, action: "selectedIndex", forControlEvents: UIControlEvents.ValueChanged)
        contentControl.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(contentControl)

        
        self.selectionStyle = UITableViewCellSelectionStyle.None
        self.accessoryType = UITableViewCellAccessoryType.None
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        let viewsDict = [
            "super":contentView,
            "contentControl":contentControl,
            ] as [String:AnyObject]
        
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[contentControl]|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[contentControl(50)]|", options: [], metrics: nil, views: viewsDict))
    }
    
    func setData(keys:[String],values:[Double],changeIndex:Int->()){
        timeMapKeys = keys
        timeMapValues = values
        self.changeIndex = changeIndex
        
        contentControl.removeAllSegments()
        
        for (index,key) in keys.enumerate(){
            print((index,key))
            contentControl.insertSegmentWithTitle(key, atIndex: UInt(index))
        }
    }
    
    func selectedIndex(){
        changeIndex?(Int(contentControl.selectedSegmentIndex))
    }
}
