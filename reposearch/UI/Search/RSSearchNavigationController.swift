//
//  RSSearchNavigationController.swift
//  reposearch
//
//  Created by mellancmyloi on 2022/04/27.
//

import UIKit


class RSSearchNavigationController: RSNavigationController {
    
    override func initView() {
        super.initView()
        
        self.navigationBar.titleTextAttributes = .H4
        
        if #available(iOS 13.0, *) {
            self.navigationBar.largeTitleTextAttributes = .Signature
        }
    }
}
