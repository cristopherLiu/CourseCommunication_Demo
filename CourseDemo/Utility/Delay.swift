//
//  Delay.swift
//  myoffice
//
//  Created by hjliu on 2015/2/5.
//  Copyright (c) 2015年 sce. All rights reserved.
//

import UIKit

/**
*  計時器，重新呼叫func
*/
class Delay: NSObject {
    
    var handler:()->()={}
    init(time:Double, handler:()->()){
        super.init()
        self.handler = handler
        NSTimer.scheduledTimerWithTimeInterval(time, target: self, selector: "exec", userInfo: nil, repeats: false)
    }
   
    func exec(){
        handler()
    }
}


typealias Task = (cancel : Bool) -> ()

func delay(time:NSTimeInterval, task:()->()) ->  Task? {
    
    func dispatch_later(block:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(time * Double(NSEC_PER_SEC))),
            dispatch_get_main_queue(),
            block)
    }
    
    var closure: dispatch_block_t? = task
    var result: Task?
    
    let delayedClosure: Task = {
        cancel in
        if let internalClosure = closure {
            if (cancel == false) {
                dispatch_async(dispatch_get_main_queue(), internalClosure);
            }
        }
        closure = nil
        result = nil
    }
    
    result = delayedClosure
    
    dispatch_later {
        if let delayedClosure = result {
            delayedClosure(cancel: false)
        }
    }
    
    return result;
}

func cancel(task:Task?) {
    task?(cancel: true)
}