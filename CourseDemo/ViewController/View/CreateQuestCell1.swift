//
//  CreateQuestCell1.swift
//  CourseDemo
//
//  Created by hjliu on 2015/12/21.
//  Copyright © 2015年 hjliu. All rights reserved.
//

import UIKit

class CreateQuestCell1: UITableViewCell {
    
    var contentLabel:UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor(red: 0.3, green: 0.5, blue: 0.88, alpha: 1)
        
        contentLabel = UILabel()
        contentLabel.font = UIFont.systemFontOfSize(30)
        contentLabel.textAlignment = NSTextAlignment.Left
        contentLabel.textColor = UIColor.whiteColor()
        contentLabel.numberOfLines = 0
        contentLabel.backgroundColor = self.backgroundColor
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(contentLabel)
        
        self.selectionStyle = UITableViewCellSelectionStyle.None
        self.accessoryType = UITableViewCellAccessoryType.None
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        let viewsDict = [
            "contentLabel":contentLabel,
            ] as [String:AnyObject]
        
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[contentLabel]|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-16-[contentLabel]-16-|", options: [], metrics: nil, views: viewsDict))
    }
    
    func setData(content:String){
        contentLabel.text = content
    }
}
