//
//  NSDate.swift
//  myoffice
//
//  Created by hjliu on 2015/5/22.
//  Copyright (c) 2015年 sce. All rights reserved.
//

import Foundation

public func ==(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs === rhs || lhs.compare(rhs) == .OrderedSame
}

public func <(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs) == .OrderedAscending
}

public func >(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs) == .OrderedDescending
}

extension NSDate: Comparable { }

extension NSDate{
    
    class func Parse(dateString:String!)->NSDate?{
        if dateString == nil {
            return nil
        }
        
        let dateFormatter = NSDateFormatter()
        
        
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        if let date = dateFormatter.dateFromString(dateString) {
            return date
        }
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let date = dateFormatter.dateFromString(dateString) {
            return date
        }
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        if let date = dateFormatter.dateFromString(dateString) {
            return date
        }
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let date = dateFormatter.dateFromString(dateString) {
            return date
        }
        
        dateFormatter.dateFormat = "yyyy/MM/dd"
        if let date = dateFormatter.dateFromString(dateString) {
            return date
        }
        return nil
    }
    
    func Hour()->String{
        let hour = NSCalendar.currentCalendar().components(NSCalendarUnit.Hour, fromDate: self).hour
        return String(format: "%02d", hour)
    }
    
    func Day()->String{
        let day = NSCalendar.currentCalendar().components(NSCalendarUnit.Day, fromDate: self).day
        return String(format: "%02d", day)
    }

    func Week()->String{
        let Weekday = NSCalendar.currentCalendar().components(NSCalendarUnit.Weekday, fromDate: self).weekday
        let map = ["","日","一","二","三","四","五","六"]

        return map[Weekday]
    }

    func Month()->String{
        let month = NSCalendar.currentCalendar().components(NSCalendarUnit.Month, fromDate: self).month
        //let map = ["","1月","2月","3月","4月","5月","6月","7月","8月","9月","10月","11月","12月"]

        return String(format: "%d", month)
    }

    func Year()->String{
        let year = NSCalendar.currentCalendar().components(NSCalendarUnit.Year, fromDate: self).year
        return "\(year)"
    }
    
    func toShortString()->String{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        return dateFormatter.stringFromDate(self)
    }
    
    func toString()->String{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        return dateFormatter.stringFromDate(self)
    }
    
    func toNormalString()->String{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM/dd HH:mm:ss"
        return dateFormatter.stringFromDate(self)
    }
    
    func addMonths(month:Int)->NSDate{
        let calendar = NSCalendar.currentCalendar()
        let offsetComponents = NSDateComponents()
        offsetComponents.month = month
        return calendar.dateByAddingComponents(offsetComponents, toDate: self, options: NSCalendarOptions())!
    }
    
    func addSecond(sec:Int)->NSDate{
        let calendar = NSCalendar.currentCalendar()
        let offsetComponents = NSDateComponents()
        offsetComponents.second = sec
        return calendar.dateByAddingComponents(offsetComponents, toDate: self, options: NSCalendarOptions())!
    }
    
    func addHour(hour:Int)->NSDate{
        let calendar = NSCalendar.currentCalendar()
        let offsetComponents = NSDateComponents()
        offsetComponents.hour = hour
        return calendar.dateByAddingComponents(offsetComponents, toDate: self, options: NSCalendarOptions())!
    }
    
    func addDay(day:Int)->NSDate{
        let calendar = NSCalendar.currentCalendar()
        let offsetComponents = NSDateComponents()
        offsetComponents.day = day
        return calendar.dateByAddingComponents(offsetComponents, toDate: self, options: NSCalendarOptions())!
    }
    
    func firstDateOfMonth(calendar:NSCalendar! = NSCalendar.currentCalendar())->NSDate{
        let components = calendar.components(
            [NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day]
            , fromDate: self)
        components.day = 1

        return calendar.dateFromComponents(components)!
    }

    func lastDateOfMonth(calendar:NSCalendar! = NSCalendar.currentCalendar())->NSDate{
        let components = calendar.components(
        [NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day]
        , fromDate: self)
        components.day = 0
        components.month = components.month + 1

        return calendar.dateFromComponents(components)!
    }

    func beginningOfDay(calendar:NSCalendar! = NSCalendar.currentCalendar())->NSDate{
        let components = calendar.components(
            [NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day]
            , fromDate: self)
        //components.hour = 0

        return calendar.dateFromComponents(components)!
    }

    func dateWithDay(day:Int , calendar:NSCalendar! = NSCalendar.currentCalendar())->NSDate{
        let components = calendar.components(
            [NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day]
            , fromDate: self)
        components.day = day

        return calendar.dateFromComponents(components)!
    }

    func nextFirstDateOfMonth(calendar:NSCalendar! = NSCalendar.currentCalendar())->NSDate{
        let components = calendar.components(
            [NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day]
            , fromDate: self)
        components.day = 1
        components.month = components.month + 1
        
        return calendar.dateFromComponents(components)!
    }

    func yearsFrom(date:NSDate) -> Int{
        return NSCalendar.currentCalendar().components(NSCalendarUnit.Year, fromDate: date, toDate: self, options: []).year
    }
    func monthsFrom(date:NSDate) -> Int{
        return NSCalendar.currentCalendar().components(NSCalendarUnit.Month, fromDate: date, toDate: self, options: []).month
    }
    func weeksFrom(date:NSDate) -> Int{
        return NSCalendar.currentCalendar().components(NSCalendarUnit.WeekOfYear, fromDate: date, toDate: self, options: []).weekOfYear
    }
    func daysFrom(date:NSDate) -> Int{

        let fromDay = NSDate.Parse(date.toShortString())!
        let toDay = NSDate.Parse(self.toShortString())!
        return NSCalendar.currentCalendar().components(NSCalendarUnit.Day, fromDate: fromDay, toDate: toDay, options: []).day
    }
    func hoursFrom(date:NSDate) -> Int{
        return NSCalendar.currentCalendar().components(NSCalendarUnit.Hour, fromDate: date, toDate: self, options: []).hour
    }
    func minutesFrom(date:NSDate) -> Int{
        return NSCalendar.currentCalendar().components(NSCalendarUnit.Minute, fromDate: date, toDate: self, options: []).minute
    }
    func secondsFrom(date:NSDate) -> Int{
        return NSCalendar.currentCalendar().components(NSCalendarUnit.Second, fromDate: date, toDate: self, options: []).second
    }
    func offsetFrom(date:NSDate) -> String {
        if yearsFrom(date)   > 0 { return "\(yearsFrom(date))y"   }
        if monthsFrom(date)  > 0 { return "\(monthsFrom(date))M"  }
        if daysFrom(date)    > 0 { return "\(daysFrom(date))d"    }
        if hoursFrom(date)   > 0 { return "\(hoursFrom(date))h"   }
        if minutesFrom(date) > 0 { return "\(minutesFrom(date))m" }
        if secondsFrom(date) > 0 { return "\(secondsFrom(date))s" }
        return ""
    }
    
    var datePart:NSDate{
        return self.beginningOfDay()
    }
    
    func isTheSameDay(date:NSDate)->Bool{
        return self.toShortString() == date.toShortString()
    }
}
