//
//  JsonTransform_Dev.swift
//  SwiftDev
//
//  Created by 华子 on 2020/7/1.
//  Copyright © 2020 HZCoding. All rights reserved.
//

import Foundation

// MARK: 自定义print 打印
private var fomatter: DateFormatter = {
    let fomatter = DateFormatter.init()
    fomatter.dateFormat = "yyyy-MM-dd hh:mm:ss.SSSS"
    return fomatter
}()

public func printLog(_ logs: Any..., file: String = #file, funcName: String = #function, lineNum: Int = #line) {
    print("🌔🌕🌖\(fomatter.string(from: NSDate() as Date)) <<\((file as NSString).lastPathComponent) --> \(funcName)>>, line:\(lineNum)")
    for item in logs {
        print(item, separator: "", terminator: "\n")
    }
}

func Dev_parseToJsonData<aJsonOBj>(_ jsonObj: aJsonOBj) -> Data? {

    if JSONSerialization.isValidJSONObject(jsonObj) {
        if let data = try? JSONSerialization.data(withJSONObject: jsonObj, options: .sortedKeys) {
            return data
        }else{
            printLog("转 data失败")
        }
    }
    printLog("该对象不适宜json解析")
    return nil
}


func Dev_parseToJsonString<aJsonOBj>(_ jsonObj: aJsonOBj) -> String {

    if let data = Dev_parseToJsonData(jsonObj) {
        if let jsonStr = String.init(data: data, encoding: .utf8) {
            return jsonStr
        }else{
            printLog("转 string失败")
        }
    }
    return ""
}

func Dev_parseToJsonObj(_ jsonStr: String) -> AnyObject {
    if let result = jsonStr.removingPercentEncoding {
        if let data = result.data(using: .utf8) {
            if let result = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves) {
                //printLog(result)
                return result as AnyObject
            }
        }
        return "" as AnyObject
    }else{
        printLog("这是一个非法的json字符串")
        return "" as AnyObject
    }
}
