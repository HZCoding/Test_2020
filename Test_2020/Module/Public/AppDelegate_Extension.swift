//
//  Scene_Extension.swift
//  Test_2020
//
//  Created by 华子 on 2020/11/21.
//

import Foundation
import UIKit

extension AppDelegate {
    func config_VCContent(_ window: UIWindow) {
        window.rootViewController = Navi_RootVC.initConfig()
        JsonStorage.config_base()
    }
}

extension AppDelegate {
}
