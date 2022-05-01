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
        
        self.titleLabel.attributedText = .Body1("검색 결과가 없습니다.", with: [.foregroundColor: R.color.textGrey() as Any], into: .center)
    }
}
