//
//  SocialChefCell.swift
//  iOS-Kuhinja
//
//  Created by Anastasija on 4.5.22..
//

import UIKit

class SocialChefCell: UITableViewCell {

    @IBOutlet weak var chefImageView: UIImageView!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var timeAgoLabel: UILabel!
}

//MARK: LifeCycle

extension SocialChefCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        chefImageView.roundedCorners(radius: 6)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

//MARK: Configuration

extension SocialChefCell {
    
    public func config( image: UIImage, comment: String, timeAgo: Int) {
        chefImageView.image = image
        commentLabel.text = comment
        timeAgoLabel.text = String(timeAgo)
        timeAgoLabel.text?.append(" mins ago")
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "SocialChefCell", bundle: nil)
    }
}
