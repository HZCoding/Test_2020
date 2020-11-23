//
//  History_VC.swift
//  Test_2020
//
//  Created by 华子 on 2020/11/21.
//

import UIKit

class History_VC: List_VC {
    
    private var dic_dateStr_ = [String : String]()
    private var isFirstRefresh = true
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        navigationItem.leftBarButtonItem?.title = "back"
        navigationItem.title = "history"
        
        logicAction_refreshData_()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(logicAction_refreshData_),
                                               name: NSNotification.Name.init(ApiList_VC.LoopKey),
                                               object: nil)
    }
    
    @objc private func logicAction_refreshData_() {
        printLog(123)
        let history = JsonStorage.share.fetchHistory()
        navigationItem.title = "history (\(history.count))"
        
        bindData(jsonData: history) { [self] in
            guard isFirstRefresh else { return }
            isFirstRefresh =  false
            let indexPath = IndexPath.init(row: history.count - 1, section: 0)
            tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: List_VC.Cell_ID_Home, for: indexPath)
        let api_key = arr_rowTitle[indexPath.row]
        var dateStr = dic_dateStr_[api_key]
        if dateStr == nil {
            dateStr = Date.dateStr(TimeInterval.init(api_key)!)
            dic_dateStr_[api_key] = dateStr as! String
        }
        cell.textLabel?.text = (dateStr!)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellValue = logicValue_CellData(indexPath)
        let historyDetailVC = List_VC.init()
        historyDetailVC.bindData(jsonData: cellValue?.value as! [String : Any])
        historyDetailVC.navigationItem.title = dic_dateStr_[(cellValue?.key)!]
        self.navigationController?.pushViewController(historyDetailVC, animated: true)
    }

}
