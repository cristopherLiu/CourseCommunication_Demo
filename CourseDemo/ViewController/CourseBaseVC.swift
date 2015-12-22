//
//  CourseBaseVC.swift
//  CourseDemo
//
//  Created by hjliu on 2015/12/18.
//  Copyright © 2015年 hjliu. All rights reserved.
//

import UIKit

class CourseBaseVC: UIViewController {
    
    let clearBtn = UIButton()
    let teacherBtn = UIButton()
    let studentBtn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.lightGrayColor()
        
        teacherBtn.setTitle("老師", forState: UIControlState.Normal)
        teacherBtn.backgroundColor = UIColor.redColor()
        teacherBtn.addTarget(self, action: "Tap:", forControlEvents: UIControlEvents.TouchUpInside)
        teacherBtn.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(teacherBtn)
        
        studentBtn.setTitle("學生", forState: UIControlState.Normal)
        studentBtn.backgroundColor = UIColor.blueColor()
        studentBtn.addTarget(self, action: "Tap:", forControlEvents: UIControlEvents.TouchUpInside)
        studentBtn.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(studentBtn)
        
        clearBtn.setTitle("清空題庫資料", forState: UIControlState.Normal)
        clearBtn.setTitleColor(UIColor.brownColor(), forState: UIControlState.Normal)
        clearBtn.backgroundColor = UIColor.greenColor()
        clearBtn.addTarget(self, action: "Clear", forControlEvents: UIControlEvents.TouchUpInside)
        clearBtn.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(clearBtn)
        
        
        let views = [
            "super":self.view,
            "clearBtn":clearBtn,
            
            "teacherBtn":teacherBtn,
            "studentBtn":studentBtn
        ]
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[super]-(<=0)-[clearBtn]", options: NSLayoutFormatOptions.AlignAllCenterX, metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[clearBtn(200)]", options: [], metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[teacherBtn]|", options: [], metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[studentBtn]|", options: [], metrics: nil, views: views))
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[teacherBtn][studentBtn(teacherBtn)]|", options: [], metrics: nil, views: views))
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-200-[clearBtn(50)]", options: [], metrics: nil, views: views))
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

//        API.setEventAnswer("string", choice: "A")
//        API.getEventList({ events in
//            print(events)
//        })
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func Tap(sender:UIButton){
        
        let nextPage = CourseList()
        
        if sender == teacherBtn{
            isTeacher = true
        }else{
            isTeacher = false
        }
        
        self.navigationController?.pushViewController(nextPage, animated: true)
    }
    
    func Clear(){
        API.removeAllEvent()
    }
}
