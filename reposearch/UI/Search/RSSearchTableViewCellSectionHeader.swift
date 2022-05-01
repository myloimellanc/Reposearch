//
//  RSSearchTableViewCellSectionHeader.swift
//  reposearch
//
//  Created by mellancmyloi on 2022/05/01.
//

import UIKit


class RSSearchTableViewCellSectionHeader: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    static func getCellHeight() -> CGFloat {
        return 40.0
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.resetView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.resetView()
    }
    
    private func resetView() {
        self.titleLabel.text?.removeAll()
    }
    
    deinit {
        print("[DEINIT]", String(describing: type(of: self)))
    }
}
