//
//  ToBuyCell.swift
//  iOS-Kuhinja
//
//  Created by Anastasija on 21.4.22..
//

import UIKit

class ToBuyCell: UITableViewCell {

    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var importanceLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!

    @IBOutlet weak var checkView: UIView!
    @IBOutlet weak var checkImage: UIImageView!
    
    static let height : CGFloat = 96.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        checkView.roundedCorners(radius: 8)
        // Initialization code
    }
    
    @IBAction func didTouchCheckButton(_ sender: UIButton) {
        checkImage.isHidden.toggle()
    }
    
}

extension UIView {
    func roundedCorners(radius: CGFloat) {
        layer.masksToBounds = true
        layer.cornerRadius = radius
    }
}
