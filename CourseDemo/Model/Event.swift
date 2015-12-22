//
//  Event.swift
//  CourseDemo
//
//  Created by hjliu on 2015/12/18.
//  Copyright © 2015年 hjliu. All rights reserved.
//

import Foundation

var isTeacher = false

class Event{
    static var list:[Event] = []
    
    convenience init(){
        self.init(title: "",time: 0,A: "",B: "",C: "",D: "")
    }
    
    init(title:String,time:Double,A:String,B:String,C:String,D:String){
        self.title = title
        self.time = time
        self.A = A
        self.B = B
        self.C = C
        self.D = D
        id = NSUUID().UUIDString //製作uuid
    }
    
    var id:String
    var title:String
    var startTime:NSDate? 
    var time:Double
    var timeRemaining:Double?
    var A:String
    var B:String
    var C:String
    var D:String
    var Acount:Int = 0
    var Bcount:Int = 0
    var Ccount:Int = 0
    var Dcount:Int = 0
}