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
    
    private static let testLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .natural
        label.numberOfLines = 0
        
        return label
    }()
    
    static func getCellHeight(by descriptionText: String, cellWidth: CGFloat) -> CGFloat {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.28
        paragraphStyle.lineBreakMode = .byWordWrapping
        
        self.testLabel.attributedText = .Body1(descriptionText, with: [.paragraphStyle: paragraphStyle])
        
        let descriptionLabelHeight = self.testLabel.sizeThatFits(CGSize(width: cellWidth - 30.0, height: .infinity))
        return descriptionLabelHeight.height + 132.0
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
