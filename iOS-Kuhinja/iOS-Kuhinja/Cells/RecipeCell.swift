//
//  RecipeCell.swift
//  iOS-Kuhinja
//
//  Created by Anastasija on 29.4.22..
//

import UIKit

class RecipeCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
}

//MARK: - LifeCycle

extension RecipeCell {
   
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.roundedCorners(radius: 6)
    }
}

//MARK: - Configuration

extension RecipeCell {
    
    public func configure(image: UIImage, name: String, neededTime: Int) {
        imageView.image = image
        nameLabel.text = name
        timeLabel.text = String(neededTime)
        timeLabel.text?.append(" min")
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "RecipeCell", bundle: nil)
    }
}
