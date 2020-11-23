//
//  Timer_Manager.swift
//  Test_2020
//
//  Created by 华子 on 2020/11/21.
//

import Foundation

class Timer_Manager: NSObject {
    static let share = Timer_Manager.init()
    private var timer_: Timer!
    
    private override init () {
        super.init()
        timer_ = Timer.init(timeInterval: 1, target: self, selector: #selector(updateTimeRecord_), userInfo: nil, repeats: true)
        RunLoop.main.add(timer_, forMode: .common)
    }
    
    @objc private func updateTimeRecord_ () {
        Timer_Record.updateTimeRecord_()
    }
}
// MARK: public Func
extension Timer_Manager {
    class func registeTimeLoop(_ key: String) {
        share.timer_.fire()
        Timer_Record.registeTimeLoop(key)
    }
}


fileprivate struct Timer_Record {
    private static var timeRecordDic = [String : Int64]()
}

// MARK: public Func
extension Timer_Record {
    static func updateTimeRecord_ () {
//        return
        guard timeRecordDic.count > 0 else { return }
        var tempRecordDic = [String : Int64]()
        timeRecordDic.forEach { (item: (key: String, value: Int64)) in
            var tempCount = item.value + 1
            if tempCount >= 6 {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: item.key), object: nil)
                tempCount = 1
            }
            tempRecordDic[item.key] = tempCount
        }
        timeRecordDic = tempRecordDic
        printLog(tempRecordDic)
    }
    
    static func registeTimeLoop(_ key: String) {
        timeRecordDic[key] = 0
    }
}
