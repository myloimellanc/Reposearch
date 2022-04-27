//
//  RSViewModel.swift
//  reposearch
//
//  Created by mellancmyloi on 2022/04/27.
//

import Foundation
import RxSwift


class RSViewModel {
    
    let disposeBag = DisposeBag()
    
    required init() {
        
    }
    
    deinit {
        print("[DEINIT]", String(describing: type(of: self)))
    }
}
