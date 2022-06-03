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
    static let height: CGFloat = 96.0
    
    private let formatter = DateFormatter()
}

//MARK: - LifeCycle

extension ToBuyCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupFormatter()
        checkView.roundedCorners(radius: 8)
    }
}

//MARK: - Actions

extension ToBuyCell {
    
    @IBAction func didTouchCheckButton(_ sender: UIButton) {
        delegate?.toBuyCell(self, didChangeCheckedState: !checkImage.isHidden)
    }
}

//MARK: - Configuration

extension ToBuyCell {
    
    public func config(name: String, importance: Int, date: Date, color: String, amount: Int, isChecked: Bool) {
        nameLabel.text = name
        importanceLabel.text = displayPriorityTitle(priority: importance)
        dateLabel.text = formatter.string(from: date)
        colorView.backgroundColor = UIColor(hexString: color)
        amountLabel.text = String(amount)
        checkImage.isHidden = !isChecked

        setImportanceTextColor(importance)

    }
}

//MARK: - Helper f-ons

extension ToBuyCell {
    
    func setupFormatter() {
        formatter.dateFormat =  K.dateFormat
    }
    
    func displayPriorityTitle(priority: Int) -> String {
        return (priority == 2) ? "High" : (priority == 1) ? "Medium" : "Low"
    }
    
    func setImportanceTextColor(_ importance: Int) {
        importanceLabel.textColor = (importance == 2) ? .systemRed : .black
    }
}
