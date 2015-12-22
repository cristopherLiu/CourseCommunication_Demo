//
//  Utility.swift
//  IOffice
//
//  Created by hjliu on 2014/10/31.
//  Copyright (c) 2014年 hjliu. All rights reserved.
//

import UIKit

class Utility: NSObject {
    
    /**
    字典檔過濾並刪除值為空白的資料欄位
    
    - parameter dic: 要過濾的字典檔
    
    - returns: 返回過濾後的dic
    */
    func dataFilter<T1,T2>(dic:Dictionary<T1,T2>)->Dictionary<T1,T2>{
        var result = dic
        for (key, value) in result
        {
            //當為空值
            if value as? String == ""{
                result[key] = nil //刪除該比資料
            }
        }
        return result
    }
    
    /**
    10進位轉成int
    
    - parameter s: hex字串
    
    - returns: 轉出後的數字
    */
    class func FromHexToInt(s:String)->Int{
        var i:UInt32 = 0
        NSScanner(string: s).scanHexInt(&i)
        return Int(i)
    }
    
    /**
    把 WebService Get 所需要傳遞的資料組成 QueryString
    比方說 我想要產生 a=1&b=2 的字串
    需要呼叫 FromDictionaryToQueryString(["a":"1","b":"2"])
    
    - parameter d: 用一個字典存傳輸的key和對應的value
    
    - returns: 組成QueryString
    */
    class func FromDictionaryToQueryString(d:[String:String])->String{
        
        let params = d.map { (key, value)->String in
            return "\(key.escaped)=\(value.escaped)"
        }
        return params.joinWithSeparator("&")
    }
    
    class func parseJson(json:String)->[AnyObject]{
        let data:NSData! = json.dataUsingEncoding(NSUTF8StringEncoding)
        var parseError: NSError?
        let parsedObject: AnyObject?
        do {
            parsedObject = try NSJSONSerialization.JSONObjectWithData(data,
                        options: NSJSONReadingOptions.AllowFragments)
        } catch let error as NSError {
            parseError = error
            parsedObject = nil
        }
        
        if let parsedObject = parsedObject as? NSArray {
            return parsedObject as [AnyObject]
        }
        if let parsedObject: AnyObject = parsedObject {
            return [parsedObject]
        }
        return []
    }

    class func toJson(dic:AnyObject) -> NSData?{
        return try? NSJSONSerialization.dataWithJSONObject(dic, options:NSJSONWritingOptions(rawValue: 0))
    }
    
    class func toJsonString(dic:AnyObject) -> String {
        
        let data = toJson(dic)
        
        if let data = data{
            return NSString(data: data, encoding: NSUTF8StringEncoding) as? String ?? ""
        }else{
            return ""
        }
    }
    
    /**
    取得os 版本
    
    - returns: "ios;裝置種類;os版本;app軟體版本"
    */
    class func getOSVersion()->String{
        return "IOS;\(UIDevice.currentDevice().modelName);\(UIDevice.currentDevice().systemVersion);\(UIDevice.getSoftVersion())"
    }

    class func dump(view:UIView){
        dump(view, level:0)
    }
    
    class func dump(view:UIView, level:Int){
        let s:String = String(count: level * 2, repeatedValue: (" " as Character))
        print("\(s)\(view)")
        for v in view.subviews {
            dump((v ), level: level+1)
        }
    }
}

