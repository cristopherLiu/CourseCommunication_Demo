//
//  MyButton.swift
//  CourseDemo
//
//  Created by hjliu on 2015/12/18.
//  Copyright © 2015年 hjliu. All rights reserved.
//

import UIKit

class MyButton: UIControl {

    var titleLabel = UILabel()
    private var contentLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel.font = UIFont.boldSystemFontOfSize(25.0)
        titleLabel.textAlignment = NSTextAlignment.Left
        titleLabel.textColor = UIColor.brownColor()
        titleLabel.backgroundColor = UIColor.clearColor()
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titleLabel)
        
        contentLabel.font = UIFont.boldSystemFontOfSize(25.0)
        contentLabel.textAlignment = NSTextAlignment.Right
        contentLabel.textColor = UIColor.brownColor()
        contentLabel.backgroundColor = UIColor.clearColor()
        contentLabel.numberOfLines = 0
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(contentLabel)
    }
    
//    override var backgroundColor: UIColor?{
//        didSet{
//            titleLabel.backgroundColor = self.backgroundColor
//            contentLabel.backgroundColor = self.backgroundColor
//        }
//    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        let viewsDict = [
            "super":self,
            "titleLabel": titleLabel,
            "contentLabel":contentLabel,
            ] as [String:AnyObject]
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[titleLabel]-[contentLabel]-|", options: [], metrics: nil, views: viewsDict))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[super]-(<=0)-[contentLabel]", options: NSLayoutFormatOptions.AlignAllCenterY, metrics: nil, views: viewsDict))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[contentLabel]", options: [], metrics: nil, views: viewsDict))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[titleLabel]-|", options: [], metrics: nil, views: viewsDict))
    }
    
    func setText(text:String , content:String){
        titleLabel.text = text
        contentLabel.text = content
    }
    
    override var selected:Bool{
        didSet{
            self.backgroundColor = UIColor.blueColor()
            titleLabel.textColor = UIColor.whiteColor()
            contentLabel.textColor = UIColor.whiteColor()
        }
    }
}
