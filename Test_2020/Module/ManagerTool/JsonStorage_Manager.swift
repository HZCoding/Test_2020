//
//  JsonStorage_Manager.swift
//  Test_2020
//
//  Created by 华子 on 2020/11/21.
//

import Foundation
import os

typealias JsonStorage = JsonStorage_Manager

class JsonStorage_Manager: NSObject {
    
    static let share = JsonStorage_Manager.init()
    
    private lazy var jsonData_ = [String : [String : Any]]()
    
    private lazy var currentLastTimestamp_: String? = {
        UserDefaults.standard.value(forKey: JsonStorage.lastTimestampKey) as? String
    }()
    private var lock_: os_unfair_lock = os_unfair_lock.init()
    
    private override init () { }
    
    
}

// MARK: Public Func
extension JsonStorage_Manager {
    class func config_base()  {
        share.configJsonPath_()
    }
    
    func insertNewJson(_ json: [String : Any]) -> String {
        let timeInterval = "\(Date.init().timeIntervalSince1970)"
        performSelector(inBackground: #selector(insertNewJson_(_:)), with: [timeInterval : json])
        return timeInterval
    }
    
    
    /// 不传值，默认获取最后一次的json数据
    func fetchJsonData(_ timestamp: String = "0") -> [String : [String : Any]]? {
        let tempTimestamp = (timestamp == "0" ? (currentLastTimestamp_ == nil ? "0" : currentLastTimestamp_) : timestamp)!
        return [tempTimestamp : fetchJsonData_()[tempTimestamp]] as? [String : [String : Any]]
    }
    
    func fetchHistory() -> [String : Any] {fetchJsonData_()}
    
    // TODO: private func
    private func fetchJsonData_() -> [String : [String : Any]] {
        os_unfair_lock_lock(&lock_)
        let dic = jsonData_
        os_unfair_lock_unlock(&lock_)
        return dic
    }
    @objc private func insertNewJson_(_ value: [String : [String : Any]]) {
        var tempJsonData = fetchJsonData_()
        tempJsonData[value.keys.first!] = value.values.first!
        os_unfair_lock_lock(&lock_)
        jsonData_ = tempJsonData
        os_unfair_lock_unlock(&lock_)
        let saveJson = NSDictionary.init(dictionary: tempJsonData)
        updateJsonStorage_(saveJson)
        printLog(tempJsonData.keys)
    }
    
}


// MARK: Storage Path
extension JsonStorage_Manager {
    private class var pathKey: String {"json.plist"}
    private class var lastTimestampKey: String {"lastTimestampKey"}
    
    private func configJsonPath_ () {
        let targetPath = logicValue_FullPath_()
        var sourceJson = NSMutableDictionary.init()
        if !FileManager.default.fileExists(atPath: targetPath) {
            FileManager.default.createFile(atPath: targetPath, contents: nil, attributes: nil)
            updateJsonStorage_(sourceJson)
        }else{
            sourceJson = NSMutableDictionary.init(contentsOf: URL.init(fileURLWithPath: targetPath)) ?? sourceJson
        }
        jsonData_ = sourceJson as! [String : [String : Any]]
        
        printLog(jsonData_.keys)
    }
    
    private func updateJsonStorage_ (_ jsonDic: NSDictionary) {
        let targetPath = logicValue_FullPath_()
        guard jsonDic.write(toFile: targetPath, atomically: true) else {
            printLog("json file init error"); return
        }
        UserDefaults.standard.setValue(jsonDic.allKeys.first,
                                       forKey: JsonStorage.lastTimestampKey)
    }
    
    /// TODO: logic
    private func logicValue_FullPath_ () -> String {
        guard let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else {
            printLog("error sandbox path fetch"); return ""
            }
        return path + "/\(JsonStorage.pathKey)"
    }
}
