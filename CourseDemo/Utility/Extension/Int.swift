//
//  Int.swift
//  myoffice
//
//  Created by hjliu on 2015/5/22.
//  Copyright (c) 2015年 sce. All rights reserved.
//

import Foundation

extension Int{
    static func random(min: Int = 0, max: Int) -> Int {
        return Int(arc4random_uniform(UInt32((max - min) + 1))) + min
    }
}
