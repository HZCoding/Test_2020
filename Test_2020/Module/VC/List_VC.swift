//
//  List_VC.swift
//  Test_2020
//
//  Created by 华子 on 2020/11/21.
//

import UIKit
import os

extension List_VC {
    class var Cell_ID_Home: String { "Cell_ID_Home" }
}

extension List_VC {
    var arr_rowTitle: [String] { arr_rowTitle_ }
    var dic_sourceData:[String : Any] {dic_sourceData_}
    var tableView: UITableView { tableView_}
}
class List_VC: UIViewController {
    
    private lazy var arr_rowTitle_ = [String]()
    private lazy var dic_sourceData_ = [String : Any]()
    private var lock_: os_unfair_lock = os_unfair_lock.init()
    
    
    private lazy var tableView_: UITableView = {
        let tempTableView = UITableView.init(frame: view.bounds)
        return tempTableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.addSubview(tableView_)
        tableView_.register(UITableViewCell.self, forCellReuseIdentifier: List_VC.Cell_ID_Home)
        tableView_.delegate = self
        tableView_.dataSource = self
        tableView_.tableFooterView = UIView.init()
    }
    

}

// MARK: tableView
extension List_VC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr_rowTitle_.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: List_VC.Cell_ID_Home, for: indexPath)
        let cellValue = logicValue_CellData(indexPath)
        cell.textLabel?.text = cellValue?.key
        cell.detailTextLabel?.text = cellValue?.value as? String
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        printLog(indexPath)
    }
}

// MARK: public func
extension List_VC {
    func bindData(jsonData: [String : Any], didRefresh_: (() -> Void)? = nil) {
        os_unfair_lock_lock(&lock_)
        arr_rowTitle_ = [String](jsonData.keys).sorted()
        dic_sourceData_ = jsonData
        os_unfair_lock_unlock(&lock_)
        DispatchQueue.main.async { [self] in
            tableView_.reloadData()
            if let closure = didRefresh_ {
                closure()
            }
        }
    }
    
}


extension List_VC {
    func logicValue_CellData(_ indexPath: IndexPath) -> (key: String?, value: Any?)? {
        guard indexPath.row < arr_rowTitle_.count else { return (nil, nil)}
        let api_key = arr_rowTitle_[indexPath.row]
        return (api_key, dic_sourceData_[api_key])
    }
}


class Item_HomeVC: UITableViewCell {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        config_Base_()
    }
    // *********
    private func config_Base_ () {
        
    }
}
