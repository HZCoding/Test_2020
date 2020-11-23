//
//  ApiDetail_VC.swift
//  Test_2020
//
//  Created by 华子 on 2020/11/22.
//

import UIKit
import Alamofire

class ApiDetail_VC: UIViewController {
    
    var apiLinkStr_: String?
    
    private lazy var tv_Content_: UITextView = {
        let tempTv = UITextView.init(frame: view.bounds)
        tempTv.font = UIFont.boldSystemFont(ofSize: 16)
        return tempTv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(tv_Content_)
//        tv_Content_.text = String.init(describing: apiDetailData)
        guard let apiLinkStr = apiLinkStr_ else {
            return
        }
        
        get(urlStr: apiLinkStr, paras: nil) { (reponse) in
            DispatchQueue.main.async { [self] in
                tv_Content_.text = String.init(describing: reponse)
            }
        } failureHandler: { (result, msg) in
            printLog(result, msg)
        }

        
    }
    
}
