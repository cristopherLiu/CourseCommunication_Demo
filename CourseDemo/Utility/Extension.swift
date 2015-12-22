//
//  extension.swift
//  IOffice
//
//  Created by hjliu on 2014/11/11.
//  Copyright (c) 2014年 hjliu. All rights reserved.
//

import Foundation
import UIKit

/**
*  字典
*/
extension NSDictionary{
    /**
    字典檔轉換成json字串
    
    - returns: 轉換後的json字串
    */
    func toJson()->String!{
        return Utility.toJsonString(self)
    }
}

extension UIViewController{
    //設定custom title
    func setNavTitle(titleText:String){
        
        let lab = UILabel()
        lab.backgroundColor = UIColor.clearColor()
        lab.textColor = UIColor.ColorRGB(0xFFFFFF, alpha: 1)
        lab.font = UIFont.systemFontOfSize(20)
        lab.text = titleText
        lab.sizeToFit()
        self.navigationItem.titleView = lab
    }
    
    func alert(title:String, message:String, okHandler:(()->())?){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        let okAction = UIAlertAction(title: "確定", style: UIAlertActionStyle.Default) { action in
            okHandler?()
        }
        alertController.addAction(okAction)
        
        self.presentViewController(alertController, animated: true, completion:nil)
    }
}

extension NSData{
    
    func parseJson()->[NSDictionary]?{
        
        let result:AnyObject? = try? NSJSONSerialization.JSONObjectWithData(self, options:NSJSONReadingOptions.MutableContainers)
        
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
        return nil
    }
}


/**
*  Image
*/
extension UIImage {
    
    /**
    製作純色image
    
    - parameter color: 顏色
    
    - returns: 製作完成的image
    */
    class func imageWithColor(color:UIColor?) -> UIImage! {
        
        let rect = CGRectMake(0.0, 0.0, 1.0, 1.0)
        
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        
        let context = UIGraphicsGetCurrentContext()
        
        if let color = color {
            
            color.setFill()
        }
        else {
            
            UIColor.whiteColor().setFill()
        }
        
        CGContextFillRect(context, rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    /**
    圖檔轉換成base64的Png圖片字串
    
    - parameter image圖檔:
    
    - returns: base64的Png圖片字串
    */
    func ToPNGBase64()->String{
        let imageData = UIImagePNGRepresentation(self)
        return imageData!.base64EncodedStringWithOptions([])
    }
    
    /**
    圖檔轉換成base64的Jpeg圖片字串
    
    - parameter image圖檔:
    
    - returns: base64的Jpeg圖片字串
    */
    func ToJPEGBase64()->String{
        let imageData = UIImageJPEGRepresentation(self, 0.1)
        return imageData!.base64EncodedStringWithOptions([])
    }
    
    /**
    調整image size
    
    - parameter image: 要調整大小的Image
    - parameter size:  image size
    
    - returns: 調整size後的image
    */
    func reSize(size:CGSize)->UIImage{
        
        //創建一個bitmap的context
        //並把它設置成當前正在使用的context
        UIGraphicsBeginImageContext(size)
        
        //繪製改變大小的圖片
        self.drawInRect(CGRectMake(0, 0, size.width, size.height))
        
        //從當前context中創建一個改變大小後的圖片
        let scaledImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return scaledImage
    }
    
    func translucentImageWithAlpha(alpha:CGFloat)->UIImage{
        UIGraphicsBeginImageContextWithOptions(self.size, false, 0.0)
        let bounds = CGRectMake(0, 0, self.size.width, self.size.height)
        self.drawInRect(bounds, blendMode: CGBlendMode.Screen, alpha: alpha)
    
        let translucentImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return translucentImage
    }
}

extension UIView {
    
    /**
    *  螢幕截圖
    */
    func capture()-> UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.mainScreen().scale)
        
        drawViewHierarchyInRect(self.bounds, afterScreenUpdates: true)
        
        // old style: layer.renderInContext(UIGraphicsGetCurrentContext())

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    /**
    查看圖層
    */
    func dump(){
        Dump(self, level:0)
    }
    
    private func Dump(view:UIView, level:Int){
        let s:String = String(count: level * 2, repeatedValue: (" " as Character))
        print("\(s)\(view)")
        for v in view.subviews {
            Dump((v ), level: level+1)
        }
    }
}

/**
*  Color
*/
extension UIColor{
    /**
    傳入16進位，轉換成顏色
    
    - parameter rgbValue: 16進位RGB
    - parameter alpha:    透明度
    
    - returns: ios可使用的color
    */
    class func ColorRGB(rgbValue: UInt,alpha:Double) -> UIColor{
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
    
    convenience init(hex:UInt,alpha:CGFloat = 1.0){
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: alpha)
    }
}

extension UITextView{
    var numberOfLines:Int{
        
        if let _ = self.font?.lineHeight{
            let n = self.contentSize.height / self.font!.lineHeight
            return Int(round(n))
        }
        return 0
    }
}

private let DeviceList = [
    /* iPod 5 */          "iPod5,1": "iPod Touch 5",
    /* iPhone 4 */        "iPhone3,1":  "iPhone 4", "iPhone3,2": "iPhone 4", "iPhone3,3": "iPhone 4",
    /* iPhone 4S */       "iPhone4,1": "iPhone 4S",
    /* iPhone 5 */        "iPhone5,1": "iPhone 5", "iPhone5,2": "iPhone 5",
    /* iPhone 5C */       "iPhone5,3": "iPhone 5C", "iPhone5,4": "iPhone 5C",
    /* iPhone 5S */       "iPhone6,1": "iPhone 5S", "iPhone6,2": "iPhone 5S",
    /* iPhone 6 */        "iPhone7,2": "iPhone 6",
    /* iPhone 6 Plus */   "iPhone7,1": "iPhone 6 Plus",
    /* iPad 2 */          "iPad2,1": "iPad 2", "iPad2,2": "iPad 2", "iPad2,3": "iPad 2", "iPad2,4": "iPad 2",
    /* iPad 3 */          "iPad3,1": "iPad 3", "iPad3,2": "iPad 3", "iPad3,3": "iPad 3",
    /* iPad 4 */          "iPad3,4": "iPad 4", "iPad3,5": "iPad 4", "iPad3,6": "iPad 4",
    /* iPad Air */        "iPad4,1": "iPad Air", "iPad4,2": "iPad Air", "iPad4,3": "iPad Air",
    /* iPad Air 2 */      "iPad5,1": "iPad Air 2", "iPad5,3": "iPad Air 2", "iPad5,4": "iPad Air 2",
    /* iPad Mini */       "iPad2,5": "iPad Mini", "iPad2,6": "iPad Mini", "iPad2,7": "iPad Mini",
    /* iPad Mini 2 */     "iPad4,4": "iPad Mini", "iPad4,5": "iPad Mini", "iPad4,6": "iPad Mini",
    /* iPad Mini 3 */     "iPad4,7": "iPad Mini", "iPad4,8": "iPad Mini", "iPad4,9": "iPad Mini",
    /* Simulator */       "x86_64": "Simulator", "i386": "Simulator"
]

extension UIApplication {
    
    class func topViewController(base: UIViewController? = UIApplication.sharedApplication().keyWindow?.rootViewController) -> UIViewController? {
        
        if let nav = base as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        
        if let tab = base as? UITabBarController {
            let moreNavigationController = tab.moreNavigationController
            
            if let top = moreNavigationController.topViewController where top.view.window != nil {
                return topViewController(top)
            } else if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        
        if let presented = base?.presentedViewController {
            return topViewController(presented)
        }
        
        return base
    }
}

public extension UIDevice {
    
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        
        let machine = systemInfo.machine
//        let mirror = reflect(machine)                // Swift 1.2
        let mirror = Mirror(reflecting: machine)  // Swift 2.0
        var identifier = ""
        
        // Swift 1.2 - if you use Swift 2.0 comment this loop out.
//        for i in 0..<mirror.count {
//            if let value = mirror[i].1.value as? Int8 where value != 0 {
//                identifier.append(UnicodeScalar(UInt8(value)))
//            }
//        }
        
        // Swift 2.0 and later - if you use Swift 2.0 uncomment his loop
         for child in mirror.children where child.value as? Int8 != 0 {
             identifier.append(UnicodeScalar(UInt8(child.value as! Int8)))
         }
        
        return DeviceList[identifier] ?? identifier
    }
    
    class func getSoftVersion() -> String {
        if let version = NSBundle.mainBundle().infoDictionary?["CFBundleShortVersionString"] as? String {
            return version
        }
        return "no version info"
    }
    
    //取得push token
//    class func getPushToken()->String{
//        
//        let appDelegate  = UIApplication.sharedApplication().delegate as! AppDelegate
//        return appDelegate.deviceToken ?? ""
//    }
    
    class func pushNotificationOnOrOff()->Bool{
        
        let type = UIApplication.sharedApplication().currentUserNotificationSettings()?.types
    
        if type == UIUserNotificationType.None{
            return false
        }
        
        return true
    }
}