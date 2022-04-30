//
//  RSSearchTableViewCellDefault.swift
//  reposearch
//
//  Created by mellancmyloi on 2022/04/27.
//

import UIKit
import RxSwift


class RSSearchTableViewCellDefault: UITableViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var ownerLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var starLabel: UILabel!
    
    private(set) var disposeBag = DisposeBag()
    
    static func getCellHeight(by descriptionText: String) -> CGFloat {
        return 162.0
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
        self.thumbnailImageView.image = nil
        self.ownerLabel.text?.removeAll()
        self.titleLabel.text?.removeAll()
        self.descriptionLabel.text?.removeAll()
        self.starLabel.text?.removeAll()
        
        self.disposeBag = DisposeBag()
    }
}
