//
//  CreateVC.swift
//  CourseDemo
//
//  Created by hjliu on 2015/12/18.
//  Copyright © 2015年 hjliu. All rights reserved.
//

import UIKit
import NYSegmentedControl

class CreateVC: UIViewController ,UITableViewDataSource , UITableViewDelegate{

    let tableView = UITableView()
    
    var questText = "下列何者不是網球的『比賽項目』之一?"
    
    let ansKeys = ["A","B","C","D"]
    var ansValues = [
        "女子單打",
        "雙人對打",
        "三人對打",
        "男子單打",
    ]
    
    let timeMapKeys = ["1分","2分","3分","5分","10分"]
    let timeMapValues:[Double] = [1,2,3,5,10]
    var selectedTime:Double = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        let Lbutton = UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.Plain, target: self, action: "cancel")
        Lbutton.tintColor = UIColor.blueColor()
        self.navigationItem.leftBarButtonItem = Lbutton
        
        let Rbutton = UIBarButtonItem(title: "完成", style: UIBarButtonItemStyle.Plain, target: self, action: "done")
        Rbutton.tintColor = UIColor.blueColor()
        self.navigationItem.rightBarButtonItem = Rbutton
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(CreateQuestCell1.self, forCellReuseIdentifier: "CreateQuestCell1")
        tableView.registerClass(CreateQuestCell2.self, forCellReuseIdentifier: "CreateQuestCell2")
        tableView.registerClass(CreateQuestCell3.self, forCellReuseIdentifier: "CreateQuestCell3")
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
        tableView.tableFooterView = UIView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableView)
        
        let views = [
            "tableView" : tableView,
            ] as [String:AnyObject]
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[tableView]|", options: [], metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[tableView]|", options: [], metrics: nil, views: views))
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        return 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        switch section{
        case 0:
            return 1
        case 1:
            return 4
        case 2:
            return 1
        default: return 0
        }
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
        switch section{
        case 0:
            return "題目"
        case 1:
            return "選項"
        case 2:
            return "計時"
        default: return nil
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        switch indexPath.section{
        case 0:
            let cell = self.tableView.dequeueReusableCellWithIdentifier("CreateQuestCell1", forIndexPath: indexPath) as! CreateQuestCell1
            cell.setData(questText)
            cell.setNeedsUpdateConstraints()
            return cell
        case 1:
            let cell = self.tableView.dequeueReusableCellWithIdentifier("CreateQuestCell2", forIndexPath: indexPath) as! CreateQuestCell2
            
            cell.setData(ansKeys[indexPath.row], content: ansValues[indexPath.row])
            cell.setNeedsUpdateConstraints()
            return cell
        case 2:
            let cell = self.tableView.dequeueReusableCellWithIdentifier("CreateQuestCell3", forIndexPath: indexPath) as! CreateQuestCell3
            cell.setData(timeMapKeys, values: timeMapValues,changeIndex: { int in
                self.selectedTime = self.timeMapValues[int]
            })
            cell.setNeedsUpdateConstraints()
            return cell
        default: return UITableViewCell()
        }
    }

    func done(){
//        Event.add(
//            questText,
//            time: selectedTime * 60 , //秒
//            A: ansValues[0],
//            B: ansValues[1],
//            C: ansValues[2],
//            D: ansValues[3]
//        )
        
        API.createEvent(
            Event(
                title: questText,
                time: selectedTime * 60, //秒
                A: ansValues[0],
                B: ansValues[1],
                C: ansValues[2],
                D: ansValues[3])
        )
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    func cancel(){
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        switch indexPath.section{
        case 0:
            let nextPage = EditQuestVC(title: "編輯題目:", content: questText, callback: { str in
                self.questText = str
                self.tableView.reloadData()
            })
            self.navigationController?.pushViewController(nextPage, animated: true)
        case 1:
            let nextPage = EditQuestVC(title: "編輯選項\(ansKeys[indexPath.row]):", content: ansValues[indexPath.row], callback: { str in
                self.ansValues[indexPath.row] = str
                self.tableView.reloadData()
            })
            self.navigationController?.pushViewController(nextPage, animated: true)
        default: break
        }
    }
}
