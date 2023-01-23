//
//  FocusCell.swift
//  HeadSpaceFocus
//
//  Created by 신희권 on 2023/01/23.
//

import UIKit

class FocusCell: UICollectionViewCell {
    
    @IBOutlet var thumnailImageView: UIImageView!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = UIColor.systemIndigo
        contentView.layer.cornerRadius = 10
        
    }
    func configure(_ item : Focus) {
        titleLabel.text = item.title
        descriptionLabel.text = item.description
        thumnailImageView.image = UIImage(named: item.imageName)?.withRenderingMode(.alwaysOriginal)
    }
}
