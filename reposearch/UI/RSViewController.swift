//
//  RSViewController.swift
//  reposearch
//
//  Created by mellancmyloi on 2022/04/27.
//

import UIKit
import RxSwift


class RSViewController<ViewModel: RSViewModel>: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    let viewModel = ViewModel()
    let disposeBag = DisposeBag()
    
    /**
     Override it for initializing UI style. Do not call thie method directly.
     */
    func initView() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initView()
    }
    
    private(set) var viewWillAppearedBefore: Bool = false
    func viewWillAppearFirst() {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if self.viewWillAppearedBefore != true {
            self.viewWillAppearedBefore = true
            
            self.viewWillAppearFirst()
        }
    }
    
    private(set) var viewDidAppearedBefore: Bool = false
    func viewDidAppearFirst() {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if self.viewDidAppearedBefore != true {
            self.viewDidAppearedBefore = true
            
            self.viewDidAppearFirst()
        }
    }
    
    deinit {
        print("[DEINIT]", String(describing: type(of: self)))
    }
}
