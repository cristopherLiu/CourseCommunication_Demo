//
//  CreateQuestCell.swift
//  CourseDemo
//
//  Created by hjliu on 2015/12/21.
//  Copyright © 2015年 hjliu. All rights reserved.
//

import UIKit

class CreateQuestCell2: UITableViewCell {

    var titleLabel:UILabel!
    var contentLabel:UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor.lightGrayColor()
        
        titleLabel = UILabel()
        titleLabel.font = UIFont.boldSystemFontOfSize(20)
        titleLabel.textAlignment = NSTextAlignment.Center
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.numberOfLines = 0
        titleLabel.backgroundColor = UIColor(red: 0.3, green: 0.5, blue: 0.88, alpha: 1)
        titleLabel.layer.cornerRadius = 25
        titleLabel.clipsToBounds = true
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        
        contentLabel = UILabel()
        contentLabel.font = UIFont.boldSystemFontOfSize(20)
        contentLabel.textAlignment = NSTextAlignment.Left
        contentLabel.textColor = self.backgroundColor
        contentLabel.numberOfLines = 0
        contentLabel.backgroundColor = UIColor.whiteColor()
        contentLabel.layer.cornerRadius = 4
        contentLabel.clipsToBounds = true
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(contentLabel)
        
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
            "titleLabel": titleLabel,
            "contentLabel":contentLabel,
            ] as [String:AnyObject]
        
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-16-[titleLabel(50)]-11-[contentLabel]-5-|", options: [], metrics: nil, views: viewsDict))
        
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[super]-(<=0)-[titleLabel]", options: NSLayoutFormatOptions.AlignAllCenterY, metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[titleLabel(50)]", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-5-[contentLabel]-5-|", options: [], metrics: nil, views: viewsDict))
    }
    
    func setData(title:String,content:String){
        titleLabel.text = title
        contentLabel.text = content
    }
}
