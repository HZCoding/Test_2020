//
//  Network_Config.swift
//  TeamPhoto
//
//  Created by huazi on 2020/10/16.
//  Copyright © 2020 ifootbook. All rights reserved.
//

import Foundation
import Alamofire

fileprivate let AppContentType: String = "application/json; charset=utf-8" //
fileprivate let AppAcceptType: String = "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8" //

fileprivate let AppVersion_Cus: String = "1.6.7"//App_AppVersion//
fileprivate let AppDevice_Cus: String = "iOS"//



enum NetStatusCode: Int {
    case successful = 200
    case successful_cus = 0
}


extension Int {
    var isNetSuccessful: Bool {
        (self == NetStatusCode.successful.rawValue ||
         self == NetStatusCode.successful_cus.rawValue)
    }
}

struct NetOption {
    static var share = NetOption.init()
    var defaultHttpHeaders: HTTPHeaders = {
        // ------------------------ 公共参数 ------------------------
        var tempHttpHeaders = HTTPHeaders.init()
        let contentType_Header = HTTPHeader.init(name: "Content-Type",
                                                 value: AppContentType)
        let accept_Header = HTTPHeader.init(name: "Accept", value: AppAcceptType)
        tempHttpHeaders.add(contentType_Header)
        tempHttpHeaders.add(accept_Header)
        
        // ------------------------ 用户校验参数 ------------------------
        let deviceType_Header = HTTPHeader.init(name: "type", value: AppDevice_Cus)
        let version_Header = HTTPHeader.init(name: "version", value: AppVersion_Cus)
        tempHttpHeaders.add(deviceType_Header)
        tempHttpHeaders.add(version_Header)
        
        
        
        return tempHttpHeaders
    }()
    var customHttpHeaders: HTTPHeaders?
    
    enum HeaderKey: String {
        case DeviceType = "type"
        case DeviceID = "deviceId"
        case Token = "token"
    }
    
    mutating func set_(name: HeaderKey, value: String) {
        defaultHttpHeaders.update(name: name.rawValue, value: value)
    }
    
    mutating func remove_(name: HeaderKey) {
        defaultHttpHeaders.remove(name: name.rawValue)
    }
}

typealias AppDomain = String
struct DomainOption {
    static var share = DomainOption.init()
    
//    #if DEBUG
//    private lazy var domain_: AppDomain = AppStorage.appValue(AppTool_Preference.domain) as! AppDomain
//    var domain: AppDomain {
//        mutating get { domain_ }
//        set {
//            domain_ = newValue
//            AppStorage.appSet(AppPreference.domain, value: domain_)
//        }
//    }
//    #else
//    var domain: AppDomain = AppDomain_Release
//    #endif
//
//    init() {
//        #if DEBUG
//        guard let domain = AppStorage.appValue(AppTool_Preference.domain) as? AppDomain else {
//            AppStorage.appSet(AppPreference.domain, value: AppDomain_develop)
//            return
//        }
//        #else
//        AppStorage.appSet(AppPreference.domain, value: domain)
//        #endif
//    }
//
//
//    subscript (simplStr simpleApi: String) -> String {
//        mutating get {
//            guard simpleApi.contains("https://") else {
//                return domain + simpleApi
//            }
//            return simpleApi
//        }
//    }
//
//    subscript (api ApiKey: ApiKey) -> String {
//        mutating get { domain + ApiKey }
//    }
    
}

typealias ApiKey = String

