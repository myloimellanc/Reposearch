//
//  RSNavigationController.swift
//  reposearch
//
//  Created by mellancmyloi on 2022/04/27.
//

import UIKit


class RSNavigationController: UINavigationController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    /**
     Do not call thie method directly.
     */
    func initView() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initView()
    }
    
    private var viewWillAppearedFirst: Bool = true
    func viewWillAppearFirst() {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if self.viewWillAppearedFirst {
            self.viewWillAppearedFirst = false
            
            self.viewWillAppearFirst()
        }
    }
    
    private var viewDidAppearedFirst: Bool = true
    func viewDidAppearFirst() {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if self.viewDidAppearedFirst {
            self.viewDidAppearedFirst = false
            
            self.viewDidAppearFirst()
        }
    }
    
    deinit {
        print("[DEINIT]", String(describing: type(of: self)))
    }
}
