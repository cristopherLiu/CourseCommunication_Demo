//
//  API.swift
//  iCanDemo
//
//  Created by etrex kuo on 2015/12/18.
//  Copyright © 2015年 etrex. All rights reserved.
//

import UIKit

class API {
    static let host = "http://app.sce.pccu.edu.tw/IcanDemo/api/"
    static let createChoiseActivity = Connection(url:"\(host)CreateChoiseActivity", method:.POST)
    static let getActivityList = Connection(url:"\(host)GetActivityList")
    static let removeChoiseActivity = Connection(url:"\(host)RemoveChoiseActivity", method:.POST)
    static let setActivityAnswer = Connection(url:"\(host)SetActivityAnswer", method:.POST)
    static let setActivityStart = Connection(url:"\(host)SetActivityStart", method:.POST)
    
    class func createEvent(event:Event){
        print(__FUNCTION__)
        let para:[String : AnyObject] = [
            "id": event.id,
            "title": event.title,
            "duration": event.time,
            "optionA": event.A,
            "optionB": event.B,
            "optionC": event.C,
            "optionD": event.D,
        ]
        API.createChoiseActivity.request(para){data in
//            print(data)
        }
    }
    
    class func getEventList(onComplete:(()->())? = nil){
        print(__FUNCTION__)
        API.getActivityList.request(nil){data in
//            print(data)
            let events = (data["data"] as? NSArray ?? []).map({ d->Event in
                let e = Event()
                e.id = d["id"] as! String
                e.title = d["title"] as! String
                e.time = d["duration"] as! Double
                e.A = d["optionA"] as! String
                e.B = d["optionB"] as! String
                e.C = d["optionC"] as! String
                e.D = d["optionD"] as! String
                e.Acount = d["countA"] as! Int
                e.Bcount = d["countB"] as! Int
                e.Ccount = d["countC"] as! Int
                e.Dcount = d["countD"] as! Int
                e.timeRemaining = d["timeRemaining"] as? Double
                e.startTime = NSDate.Parse(d["startDate"] as? String)
                return e
            })
            Event.list = events.reverse()
            onComplete?()
        }
    }
    
    
    class func removeAllEvent(){
        print(__FUNCTION__)
        let para = [
            "activityId" : "",
        ]
        API.removeChoiseActivity.request(para){data in
            getEventList()
        }
    }
    
    class func setEventAnswer(id:String, choice:String){
        print(__FUNCTION__)
        let para = [
            "activityId" : id,
            "choiseId" : choice
        ]
        API.setActivityAnswer.request(para){data in
            print(data)
        }
    }

    class func setEventStart(id:String){
        print(__FUNCTION__)
        let para = [
            "activityId" : id
        ]
        API.setActivityStart.request(para){data in
            print(data)
        }
    }
    
    
    class func createChoiseActivityTest(){
        print(__FUNCTION__)
        let para = [
            "id": "string",
            "title": "string",
            "duration": 0,
            "optionA": "string",
            "optionB": "string",
            "optionC": "string",
            "optionD": "string",
        ]
        API.createChoiseActivity.request(para){data in
            print(data)
        }
    }
    
    class func getActivityListTest(){
        print(__FUNCTION__)
        API.getActivityList.request(nil){data in
            print(data)
        }
    }
    
    class func removeChoiseActivityTest(){
        print(__FUNCTION__)
        let para = [
            "activityId" : "",
        ]
        API.removeChoiseActivity.request(para){data in
            print(data)
        }
    }
    
    class func setActivityAnswerTest(){
        print(__FUNCTION__)
        let para = [
            "activityId" : "string",
            "choiseId" : "A"
        ]
        API.setActivityAnswer.request(para){data in
            print(data)
        }
    }
    
    class func setActivityStartTest(){
        print(__FUNCTION__)
        let para = [
            "activityId" : "string"
        ]
        API.setActivityStart.request(para){data in
            print(data)
        }
    }
    
}