//
//  Course_TVC.swift
//  CourseDemo
//
//  Created by hjliu on 2015/12/18.
//  Copyright © 2015年 hjliu. All rights reserved.
//

import UIKit

class CourseList: UIViewController ,UITableViewDataSource , UITableViewDelegate {
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.whiteColor()
        
        if isTeacher{
            let button = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "Add")
            button.tintColor = UIColor.blackColor()
            self.navigationItem.rightBarButtonItem = button
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(EventCell.self, forCellReuseIdentifier: "EventCell")
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableView)
        
        let views = [
            "tableView" : tableView,
            ] as [String:AnyObject]
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[tableView]|", options: [], metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[tableView]|", options: [], metrics: nil, views: views))
        
        //註冊notification
        
    }
    
    var needUpdate:Bool = true
    
    func getEventListOnComplete(){
        
        self.tableView.reloadData()
//        print("getEventListOnComplete \(NSDate().toNormalString())")
        
        if needUpdate{
            Delay(time:1,
                handler: {
                API.getEventList(self.getEventListOnComplete)
            })
            
//            delay(1, task: {
//                API.getEventList(self.getEventListOnComplete)
//            })
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        needUpdate = true
        getEventListOnComplete()
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        needUpdate = false
    }
    
    func Add(){
        let nextPage = UINavigationController(rootViewController: CreateVC())
        self.presentViewController(nextPage, animated: true, completion: {})
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return Event.list.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("EventCell", forIndexPath: indexPath) as! EventCell
        let data = Event.list[indexPath.row]
        
        cell.setData(data, selectChange: { int in })
        cell.setNeedsUpdateConstraints()
        return cell
    }
}
