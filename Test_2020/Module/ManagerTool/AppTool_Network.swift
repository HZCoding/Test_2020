//
//  AppTool_Network.swift
//  TeamPhoto
//
//  Created by huazi on 2020/10/16.
//  Copyright © 2020 ifootbook. All rights reserved.
//

import UIKit
import Alamofire
import HandyJSON



/// [String : Any] 格式指定
typealias NetDataType = [String : Any]
typealias JsonString = String
typealias SuccessfulHandler = ((_ info: NetDataType) -> Void)
typealias SuccessfulJsonHandler = ((_ info: JsonString) -> Void)
typealias FailureHandler = ((_ reusult: Bool, _ msg: String) -> Void)

// MARK: - - --------------- AppTool_Network 网络模块 ----------------
class AppTool_Network: NSObject {
    
    static let share = AppTool_Network.init()
    
    
    class func getRequest(_ urlStr: URLConvertible, paras: Parameters? = nil) {
        getRequest(urlStr, paras: paras, successHandler: nil, failureHandler: nil)
    }
    class func getRequest(_ urlStr: URLConvertible, paras: Parameters? = nil,
                          successHandler: SuccessfulHandler? = nil,
                          failureHandler: FailureHandler? = nil) {
        request_(urlStr, method: .get, parameters_: paras,
                 successHandler_: successHandler, failureHandler_: failureHandler)
    }
    
    class func postRequest(_ urlStr: URLConvertible, paras: Parameters?) {
        postRequest(urlStr, paras: paras, successHandler: nil, failureHandler: nil)
    }
    class func postRequest(_ urlStr: URLConvertible, paras: Parameters? = nil, successHandler: SuccessfulHandler? = nil, failureHandler: FailureHandler? = nil) {
        request_(urlStr, method: .post, parameters_: paras,
                 successHandler_: successHandler, failureHandler_: failureHandler)
    }
    
    /*
     AF.request(<#T##convertible: URLConvertible##URLConvertible#>,
                method: <#T##HTTPMethod#>,
                parameters: <#T##Parameters?#>,
                encoding: <#T##ParameterEncoding#>,
                headers: <#T##HTTPHeaders?#>,
                interceptor: <#T##RequestInterceptor?#>,
                requestModifier: <#T##Session.RequestModifier?##Session.RequestModifier?##(inout URLRequest) throws -> Void#>)
     */
    
    private class func request_(_ convertible: URLConvertible,
                          method: HTTPMethod,
                          parameters_: Parameters? = nil,
                          successHandler_: SuccessfulHandler? = nil,
                          failureHandler_: FailureHandler? = nil) {
        
        
        let successHandler = { (_ data: [String : Any]) in
            guard let tempHandler = successHandler_ else { return }
            tempHandler(data)
        }
        func failureHanlder (_ result: Bool, _ msg: String = "未知错误") {
            guard let tempHandler = failureHandler_ else { return }
            tempHandler(result, msg)
        }
        
        let encoding: ParameterEncoding = (method == .get ?
                                            URLEncoding.default :
                                            JSONEncoding.default)
        
        let headers = (NetOption.share.customHttpHeaders == nil ?
                        NetOption.share.defaultHttpHeaders :
                        NetOption.share.customHttpHeaders)
        
        let dataRequest = AF.request(convertible,
                                     method: method,
                                     parameters: parameters_,
                                     encoding: encoding,
                                     headers: headers,
                                     interceptor: nil,
                                     requestModifier: nil)
        print("\n\n🔺🔺🔺🔺🔺🔺🔺🔺:\n🔺🔺->发送接口:", convertible, "🔺🔺-> para",parameters_, "🔺🔺->headers", headers, separator: "\n", terminator: "\n")
        
        dataRequest.responseJSON { (response: AFDataResponse<Any>) in
            //debugPrint("<<< debug Net Print >>>", response)
            print("\n\n🔻🔻🔻🔻🔻🔻🔻🔻:\n🔻🔻->接口返回\n", dataRequest)
            // 未获取到状态码
            guard let statusCode = response.response?.statusCode else {
                failureHanlder(false)
                return
            }
            // 获取到的状态码 没有成功
            guard statusCode.isNetSuccessful else {
                failureHanlder(false)
                return
            }
            // 没有获取到指定 类型返回值
            guard let responseData = response.value as? NetDataType else {
                failureHanlder(false)
                return
            }
            
            print("🔻🔻->接口返回数据\n", responseData, "\n\n")
            successHandler(responseData)
            

        }
//        printLog(dataRequest)
    
    }
    
    
    
    class func request_(_ convertible: URLConvertible,
                          method: HTTPMethod,
                          parameters_: Parameters? = nil,
                          successHandler_: SuccessfulJsonHandler? = nil,
                          failureHandler_: FailureHandler? = nil) {
        
        
        let successHandler = { (_ data: JsonString) in
            guard let tempHandler = successHandler_ else { return }
            tempHandler(data)
        }
        func failureHanlder (_ result: Bool, _ msg: String = "未知错误") {
            guard let tempHandler = failureHandler_ else { return }
            tempHandler(result, msg)
        }
        
        let encoding: ParameterEncoding = (method == .get ?
                                            URLEncoding.default :
                                            JSONEncoding.default)
        
        let headers = (NetOption.share.customHttpHeaders == nil ?
                        NetOption.share.defaultHttpHeaders :
                        NetOption.share.customHttpHeaders)
        
        let dataRequest = AF.request(convertible,
                                     method: method,
                                     parameters: parameters_,
                                     encoding: encoding,
                                     headers: headers,
                                     interceptor: nil,
                                     requestModifier: nil)
        dataRequest.responseString { (responseJson: AFDataResponse<String>) in
            
            //debugPrint("<<< debug Net Print >>>", response)
            // 未获取到状态码
            guard let statusCode = responseJson.response?.statusCode else {
                failureHanlder(false)
                return
            }
            // 获取到的状态码 没有成功
            guard statusCode.isNetSuccessful else {
                failureHanlder(false)
                return
            }
            // 没有获取到指定 类型返回值
            guard let responseString = responseJson.value as? JsonString else {
                failureHanlder(false)
                return
            }
            let jsonObject = responseString.dictionaryJson
            guard jsonObject.count > 0 else {
                failureHanlder(false, "未知错误")
                return
            }
            successHandler(responseString)
        }
        
    }
    
    
}





