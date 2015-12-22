//
//  ImageUtility.swift
//  Ican
//
//  Created by hjliu on 2015/9/23.
//  Copyright © 2015年 hjliu. All rights reserved.
//

import UIKit

class ImageUtil: NSObject {
    
    //image to local path
    class func saveImage(image:UIImage?,pathName:String,onComplete:(()->Void)?){
        
        if let image = image{
            let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
            let destinationPath = documentsPath.stringByAppendingPathComponent(pathName)
            let isSave:Bool = UIImageJPEGRepresentation(image,1.0)!.writeToFile(destinationPath, atomically: true)
            
            //儲存成功後要做的事
            if isSave == true{
                if let onComplete = onComplete{
                    onComplete()
                }
            }
        }
    }
    
    /**
    從local文件夾取得圖片
    
    - parameter pathName: 要取的圖片名稱
    
    - returns: 返回取得的圖片，如果沒該檔案則返回空值
    */
    class func getImage(pathName:String)->UIImage?{
        //路徑
        let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        let destinationPath = documentsPath.stringByAppendingPathComponent(pathName)
        
        let fm = NSFileManager()
        var data:NSData!
        
        //如果路徑檔案存在
        if fm.fileExistsAtPath(destinationPath) == true{
            data = fm.contentsAtPath(destinationPath)
            return UIImage(data: data)
        }
        return nil
    }
    
    /**
    移除在local文件夾裏的相對應名稱圖片
    
    - parameter pathName: 要移除的圖檔名稱
    
    - returns: 返回是否成功
    */
    class func removeImage(pathName:String)->Bool{
        //路徑
        let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        let destinationPath = documentsPath.stringByAppendingPathComponent(pathName)
        
        let fm = NSFileManager()
        
        //如果路徑檔案存在
        if fm.fileExistsAtPath(destinationPath) == true{
            do {
                try fm.removeItemAtPath(destinationPath)
                return true
            } catch _ {
                return false
            }
        }
        return false
    }
}

