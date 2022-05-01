//
//  RSSearchTableEmptyBackgroundView.swift
//  reposearch
//
//  Created by mellancmyloi on 2022/04/29.
//

import UIKit


class RSSearchTableEmptyBackgroundView: UIView {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.titleLabel.attributedText = .Body1(R.string.localizable.searchListEmptyTitle(), with: [.foregroundColor: R.color.textGrey() as Any], into: .center)
    }
    
    deinit {
        print("[DEINIT]", String(describing: type(of: self)))
    }
}
