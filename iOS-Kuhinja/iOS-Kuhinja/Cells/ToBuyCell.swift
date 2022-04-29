//
//  ToBuyCell.swift
//  iOS-Kuhinja
//
//  Created by Anastasija on 21.4.22..
//

import UIKit

protocol ToBuyCellDelegate: AnyObject {
    func toBuyCell(_ toBuyCell: ToBuyCell, didChangeCheckedState isChecked: Bool)
}

class ToBuyCell: UITableViewCell {

    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var importanceLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!

    @IBOutlet weak var checkView: UIView!
    @IBOutlet weak var checkImage: UIImageView!
    
    weak var delegate: ToBuyCellDelegate?
    
    static let height : CGFloat = 96.0
    
    //var onCheckHandler: ((Bool) -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        checkView.roundedCorners(radius: 8)
    }
    
    @IBAction func didTouchCheckButton(_ sender: UIButton) {
        delegate?.toBuyCell(self, didChangeCheckedState: !checkImage.isHidden)
        //onCheckHandler?(!checkImage.isHidden)
    }
    
}


