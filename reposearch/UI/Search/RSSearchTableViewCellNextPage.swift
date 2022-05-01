//
//  RSSearchTableViewCellNextPage.swift
//  reposearch
//
//  Created by mellancmyloi on 2022/04/30.
//

import UIKit


class RSSearchTableViewCellNextPage: UITableViewCell {
    
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    static func getCellHeight() -> CGFloat {
        return 60.0
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.indicatorView.stopAnimating()
    }
    
    deinit {
        print("[DEINIT]", String(describing: type(of: self)))
    }
}
