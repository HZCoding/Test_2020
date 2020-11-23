//
//  Date_Extension.swift
//  Test_2020
//
//  Created by 华子 on 2020/11/21.
//

import Foundation

private let PointFomatter: DateFormatter = {
    let dateFormatter = DateFormatter.init()
    dateFormatter.dateFormat = "yyyy-MM-dd EE hh:mm:ss.S"
    return dateFormatter
}()
extension Date {
    static func dateStr(_ timeInterval: TimeInterval, dateFormatter: DateFormatter = PointFomatter) -> String {
        let date = Date.init(timeIntervalSince1970: timeInterval)
        let dateStr = PointFomatter.string(from: date)
        return dateStr
    }
}
