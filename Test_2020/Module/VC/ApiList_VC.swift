//
//  Home_VC.swift
//  Test_2020
//
//  Created by 华子 on 2020/11/21.
//

import UIKit

extension ApiList_VC {
    class var LoopKey: String { "HomeLoop" }
    enum PageType {
        case Home
        case HistroyList
    }
}

/*
 */

class ApiList_VC: List_VC {
    
    private var barItem_history__: UIBarButtonItem?
    lazy var currentPageType: PageType = .Home
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        guard currentPageType == .Home else {return}
        
        barItem_history__ = UIBarButtonItem.init(title: "history", style: .plain, target: self, action: #selector(action_History_))
        navigationItem.setRightBarButtonItems([barItem_history__!], animated: false)
        barItem_history__!.isEnabled = false
        
        Timer_Manager.registeTimeLoop(ApiList_VC.LoopKey)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(timeLoop(_:)),
                                               name: NSNotification.Name.init(ApiList_VC.LoopKey),
                                               object: nil)
        
        guard let jsonData = JsonStorage.share.fetchJsonData() else { return }
        barItem_history__!.isEnabled = true
        bindData(jsonData: jsonData.values.first!)
        bindTimerInterval(timeIntervalStr: jsonData.keys.first!)
        
    }
    
    @objc func timeLoop(_ notifi: Notification)  {
        printLog(notifi)
        requestData()
    }
    
    func bindTimerInterval (timeIntervalStr: String) {
        let timerInterval = TimeInterval.init(timeIntervalStr)!
        let dateStr = Date.dateStr(timerInterval)
        navigationItem.title = dateStr
    }

    @objc func action_History_() {
        printLog("history")
        self.navigationController?.pushViewController(History_VC.init(), animated: true)
    }
    
}

extension ApiList_VC {
    private func requestData () {
        get(urlStr: "https://api.github.com/", paras: nil) { [self] (response) in
            printLog(response)
            bindData(jsonData: response)
            let timeInterval = JsonStorage.share.insertNewJson(response)
            bindTimerInterval(timeIntervalStr: timeInterval)
            DispatchQueue.main.async {
                barItem_history__!.isEnabled = true
            }
            
        } failureHandler: { (result, msg) in
            printLog(result, msg)
        }
    }
}


extension ApiList_VC {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellValue = logicValue_CellData(indexPath)
        let apiDetailVC = ApiDetail_VC.init()
        apiDetailVC.apiLinkStr_ = cellValue?.value as? String
        self.navigationController?.pushViewController(apiDetailVC, animated: true)
    }
}
