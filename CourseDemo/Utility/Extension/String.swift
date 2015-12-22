//
//  String.swift
//  myoffice
//
//  Created by hjliu on 2015/5/22.
//  Copyright (c) 2015年 sce. All rights reserved.
//

import UIKit

extension String {
    
    var lastPathComponent: String {
        
        get {
            return (self as NSString).lastPathComponent
        }
    }
    var pathExtension: String {
        
        get {
            
            return (self as NSString).pathExtension
        }
    }
    var stringByDeletingLastPathComponent: String {
        
        get {
            
            return (self as NSString).stringByDeletingLastPathComponent
        }
    }
    var stringByDeletingPathExtension: String {
        
        get {
            
            return (self as NSString).stringByDeletingPathExtension
        }
    }
    var pathComponents: [String] {
        
        get {
            
            return (self as NSString).pathComponents
        }
    }
    
    func stringByAppendingPathComponent(path: String) -> String {
        
        let nsSt = self as NSString
        
        return nsSt.stringByAppendingPathComponent(path)
    }
    
    func stringByAppendingPathExtension(ext: String) -> String? {
        
        let nsSt = self as NSString
        
        return nsSt.stringByAppendingPathExtension(ext)
    }
    
    
    //Url特殊字元處理
    var escaped: String {
        return CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,self,"[].",":/?&=;+!@#$()',*",CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)) as String
    }
    
    func trim()->String{
        return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    }
    
    /**
    base64字串轉換成image的圖檔
    
    - parameter base64String: base64的圖片字串
    
    - returns: 圖檔 or nil
    */
    func ToImage()->UIImage?{
        let decodedData = NSData(base64EncodedString: self, options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)
        
        if let decodedData = decodedData{
            return UIImage(data: decodedData)
        }
        return nil
    }
    
    /**
    Url的圖片網址取圖並轉換成base64的圖片字串
    
    - parameter urlString: Url的圖片網址
    
    - returns: base64的圖片字串
    */
    func URLGetImageBase64()->String{
        let url:NSURL = NSURL(string : self)!
        let imageData:NSData = try! NSData(contentsOfURL: url, options: [])
        return imageData.base64EncodedStringWithOptions([])
    }
    
    func URLDecode()->String{
        
        return self.stringByRemovingPercentEncoding ?? ""
//        return self.stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding) ?? ""
    }
    
    func URLEncode()->String{
        
        return self.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLFragmentAllowedCharacterSet()) ?? ""
//        return self.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding) ?? ""
    }
    
    //string轉換bool
    func toBool() -> Bool? {
        switch self {
        case "True", "true", "yes", "1":
            return true
        case "False", "false", "no", "0":
            return false
        default:
            return nil
        }
    }
    
    func substringFromIndex(from:Int)->String{
        let nsstring = self as NSString
        return nsstring.substringFromIndex(from)
    }
    
    var Count:Int{
        return self.utf16.count
    }
    
    func Split(char:String)->[String]{
        var c:Character = " "
        if char.Count <= 1 {
            c = Character(char)
        }
        return self.characters.split{$0 == c}.map { String($0) }
    }
    func replace(target: String,withString:String)->String{
        return self.stringByReplacingOccurrencesOfString(target, withString: withString)
    }
    
    /**
    字串第一字元是否為中文
    
    - returns: 是否為中文
    */
    func firstCharIsChinese()->Bool{
        
        let range:NSRange = NSMakeRange(0, 1)
        let subString:NSString = (self as NSString).substringWithRange(range)
        let cString = subString.UTF8String
        
        if strlen(cString) == 3
        {
            return true
        }
        return false
    }
    
    func contains(find: String) -> Bool{
        return self.lowercaseString.rangeOfString(find.lowercaseString) != nil
    }
    
    func toDouble() -> Double? {
        return NSNumberFormatter().numberFromString(self)?.doubleValue
    }
    
    func parseJson()->[NSDictionary]?{
        
        let nsdata = (self as NSString).dataUsingEncoding(NSUTF8StringEncoding)
        
        if let nsdata = nsdata{
            
            let result:AnyObject? = try? NSJSONSerialization.JSONObjectWithData(nsdata, options:NSJSONReadingOptions.MutableContainers)
            
            if let result:AnyObject = result{
                
                //格式為副數dic(Array)
                if result is NSArray{
                    return result as? [NSDictionary]
                }
                    //格式為單數dic
                else if result is NSDictionary{
                    return  [result as! NSDictionary]
                }
            }
        }
        
        return nil
    }
}
