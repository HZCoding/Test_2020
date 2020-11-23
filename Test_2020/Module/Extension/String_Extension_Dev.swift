//
//  String_Extension_Dev.swift
//  SwiftDev
//
//  Created by 华子 on 2020/7/1.
//  Copyright © 2020 HZCoding. All rights reserved.
//

import Foundation

extension String {
    var arrayJson: Array<Any> {
        if let result = Dev_parseToJsonObj(self) as? Array<Any> {
            return result
        }else if dictionaryJson.count > 0 {
            printLog("***** 这是一个Dictionary类型的json对象，请使用 dictionaryJson属性进行获取 ***** \n\(dictionaryJson)")
        }
        return [Any]()
    }
    
    var dictionaryJson: Dictionary<String, Any> {
        if let result = Dev_parseToJsonObj(self) as? Dictionary<String, Any> {
            return result
        }else if arrayJson.count > 0 {
            printLog("***** 这是一个Array类型的json对象，请使用 arrayJson属性进行获取 ***** \n\(arrayJson)")
        }
        return [String:Any]()
    }
    
}
