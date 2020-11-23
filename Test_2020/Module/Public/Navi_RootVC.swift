//
//  Navi_RootVC.swift
//  Test_2020
//
//  Created by 华子 on 2020/11/21.
//

import UIKit

class Navi_RootVC: UINavigationController {

    class func initConfig() -> Navi_RootVC{
        Navi_RootVC.init(rootViewController: ApiList_VC.init())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .red
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
