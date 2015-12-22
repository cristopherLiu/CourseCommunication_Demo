//
//  Connection.swift
//  iCanDemo
//
//  Created by etrex kuo on 2015/12/18.
//  Copyright © 2015年 etrex. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class Connection: NSObject {
    var url:String = ""
    var method:Alamofire.Method = Alamofire.Method.GET
    init(url:String){
        self.url = url
    }
    init(url:String, method:Alamofire.Method){
        self.url = url
        self.method = method
    }
    func request(para:[String:AnyObject]?,onComplete:NSDictionary->()){
        
        Alamofire.request(method , url, parameters: para, encoding: .JSON)
            .response { request, response, data, error in
                //有error
                if let _ = error {
                    onComplete(["error":error ?? "response"])
                    print("error:\(error)")
                    return
                }
                //有回傳資料
                guard let result = data?.parseJson()?.first else {
                    onComplete(["error":"parseJson"])
                    return
                }
                
                onComplete(result)
        }
    }
}



