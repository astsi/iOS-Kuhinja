//
//  IngredientCell.swift
//  iOS-Kuhinja
//
//  Created by Anastasija on 27.5.22..
//

import UIKit

protocol IngredientCellDelegate: AnyObject {
    func ingredientCell(_ ingredientCell: IngredientCell, didChangeCheckedState isChecked: Bool)
}

class IngredientCell: UITableViewCell {

    @IBOutlet weak var checkView: UIView!
    @IBOutlet weak var checkImage: UIImageView!
    @IBOutlet weak var ingredientLabel: UILabel!
    
    weak var delegate: IngredientCellDelegate?
    
    @IBAction func didTouchCheckButton(_ sender: UIButton) {
        delegate?.ingredientCell(self, didChangeCheckedState: !checkImage.isHidden)
    }
}

//MARK: - LifeCycle

extension IngredientCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        checkView.roundedCorners(radius: 6)
    }
}

//MARK: - Navigation Config
    
extension IngredientCell {
    
    public func config(_ ingredient: String) {
        ingredientLabel.text = ingredient
    }
    
    static func nib() -> UINib {
        return UINib(nibName: K.ingredientCell, bundle: nil)
    }
}

//MARK: - Selection

extension IngredientCell {
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
