//
//  Array.swift
//  myoffice
//
//  Created by hjliu on 2015/5/22.
//  Copyright (c) 2015年 sce. All rights reserved.
//

import Foundation

extension Array {
    
    func find(includedElement: Element -> Bool) -> Int? {
        for (idx, element) in self.enumerate() {
            if includedElement(element) {
                return idx
            }
        }
        return nil
    }
    
    func groupBy(groupByKey:Element->String)->[String:[Element]]{
        
        //list
        var groupList = [String:[Element]]()
        
        for data in self{
            //群組名稱
            let group:String = groupByKey(data)
            
            //有該group存在,資料存入該group
            if groupList[group] != nil{
                groupList[group]!.append(data)
            }else{
                groupList[group] = [data]
            }
        }
        return groupList
    }
    
    func contains<T:Equatable>(input: T) -> Bool {
        return self.filter({$0 as? T == input}).count > 0
    }
    
    func distinct<T:Equatable>(_:T)->[T]{
        var ans = [T]()
        
        for a in self{
            if !ans.contains(a as! T){
                ans.append(a as! T)
            }
        }
        return ans
    }
    
    /**
    陣列做交集
    
    - parameter value: 單一元素
    
    - returns: 交集後的陣列
    */
    mutating func union <T: Equatable> (value: T) -> Array {
        
        if self.contains(value) == false {
            self.append(value as! Element)
        }
        
        return self
    }
    
    /**
    //陣列做交集
    
    - parameter values: 陣列
    
    - returns: 交集後的陣列
    */
    mutating func union <T: SequenceType, U: Equatable where U==T.Generator.Element> (values: T) -> Array {
        
        for value in values {
            if self.contains(value) == false {
                self.append(value as! Element)
            }
        }
        
        return self
    }
    
    mutating func remove <U: Equatable> (element: U) {
        let anotherSelf = self
        
        removeAll(keepCapacity: true)
        
        anotherSelf.each {
            (index: Int, current: Element) in
            if (current as! U) != element {
                self.append(current)
            }
        }
    }
    
    func each (call: (Int, Element) -> ()) {
        
        for (index, item) in self.enumerate() {
            call(index, item)
        }
        
    }
}

extension SequenceType where Generator.Element : Comparable{
    
    func distinct()->[Generator.Element]{
        var ans:[Generator.Element] = []
        
        for a in self{
            if !ans.contains(a){
                ans.append(a)
            }
        }
        return ans
    }
}
