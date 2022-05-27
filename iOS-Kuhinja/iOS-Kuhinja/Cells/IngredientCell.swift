//
//  IngredientCell.swift
//  iOS-Kuhinja
//
//  Created by Anastasija on 27.5.22..
//

import UIKit

class IngredientCell: UITableViewCell {

    @IBOutlet weak var ingredientLabel: UILabel!
}

//MARK: - LifeCycle

extension IngredientCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
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
