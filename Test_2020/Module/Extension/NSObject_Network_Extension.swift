//
//  NSObject_Network_Extension.swift
//  TeamPhoto
//
//  Created by huazi on 2020/10/16.
//  Copyright © 2020 ifootbook. All rights reserved.
//

import Foundation
import Alamofire

// MARK: - - --------------- 快速扩展网络请求 ----------------
extension NSObject {
    /// 任意类 类调用get接口
    class func get(_ urlStr: URLConvertible, paras: Parameters? = nil,
                   successHandler: SuccessfulHandler? = nil,
                   failureHandler: FailureHandler? = nil) {
        AppTool_Network.getRequest(urlStr, paras: paras,
                               successHandler: successHandler,
                               failureHandler: failureHandler)
    }
    
    /// 任意类 类调用Post接口
    class func post(urlStr: URLConvertible, paras: Parameters? = nil,
                    successHandler: SuccessfulHandler? = nil,
                    failureHandler: FailureHandler? = nil) {
        AppTool_Network.postRequest(urlStr, paras: paras,
                                successHandler: successHandler,
                                failureHandler: failureHandler)
    }
    
    /// 任意类对象 类调用get接口
    func get(urlStr: URLConvertible, paras: Parameters? = nil,
             successHandler: SuccessfulHandler? = nil,
             failureHandler: FailureHandler? = nil) {
        AppTool_Network.getRequest(urlStr, paras: paras,
                                   successHandler: successHandler,
                                   failureHandler: failureHandler)
    }
    
    /// 任意类对象 类调用Post接口
    func post(urlStr: URLConvertible, paras: Parameters? = nil,
              successHandler: SuccessfulHandler? = nil,
              failureHandler: FailureHandler? = nil) {
        AppTool_Network.postRequest(urlStr, paras: paras,
                                successHandler: successHandler,
                                failureHandler: failureHandler)
    }

    // TODO: - 用户模块
    // ------------------------ 分割线 ------------------------
}
