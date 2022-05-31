//
//  ViewRecipeViewController.swift
//  iOS-Kuhinja
//
//  Created by Anastasija on 19.4.22..
//

import UIKit
import RealmSwift

struct Ingredient {
    let name: String
    var isChecked: Bool
}

class ViewRecipeViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var kcalLabel: UILabel!
    @IBOutlet weak var ingredientsTableView: UITableView!
    
    weak var delegate: UIViewController?
    var recipe: Recipe?
    var ingredients: [Ingredient] = []
}

// MARK: - LifeCycle

extension ViewRecipeViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

//MARK: - UI

extension ViewRecipeViewController {
    
    func setupUI() {
        setupInitialValues()
        setupTableView()
    }
    
    func setupTableView() {
        ingredientsTableView.register(.init(nibName: K.ingredientCell, bundle: nil), forCellReuseIdentifier: K.ingredientCell)
        delegate = self
    }
    
    func setupInitialValues() {
        if let newRecipe = recipe {
            imageView.image = newRecipe.image.loadImage()
            imageView.roundedCorners(radius: 8)
            nameLabel.text = newRecipe.name
            kcalLabel.text = "\(newRecipe.kcal) KCAL"
        }
    }
}

//MARK: - TableView

extension ViewRecipeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipe?.ingredients.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ingredient = recipe?.ingredients[indexPath.row] ?? ""
        let cell = tableView.dequeueReusableCell(withIdentifier: K.ingredientCell, for: indexPath) as! IngredientCell
        cell.config(ingredient)
        ingredients.append(Ingredient(name: ingredient, isChecked: false))
        cell.delegate = self
        return cell
    }
}

extension ViewRecipeViewController: IngredientCellDelegate {
    func ingredientCell(_ ingredientCell: IngredientCell, didChangeCheckedState isChecked: Bool) {
        ingredientCell.checkImage.isHidden.toggle()
        changeIsCheckedProperty(ingredientCell)
    }
}

//MARK: - Actions

extension ViewRecipeViewController {
    //dozvoljeno jedno dodavanje - kako ostvariti???
    //ideja 1:
    //Dodati checkirane iteme u listu i ukoliko se sadrzaj liste izmenio, dodati samo novi sadrzaj
    //ideja 2:
    //Pamtiti da li se ranije vec kliknulo na dugme i izbaciti poruku tipa "Are you sure you want to add items to the list again?" - opet treba pamtiti i koji su itemi dodati - uporedjivanje po imenu
    
    @IBAction func addToCartTouched(_ sender: UIButton) {
        
        //1. proveri za svaki cell iz tabele da li mu je checkmark hidden
        for ingredient in ingredients {
            if ingredient.isChecked {
                let item = ItemToBuy(name: ingredient.name,
                                     amount: 1,
                                     date: Date(),
                                     hexColor: "ff0000",
                                     priority: 1,
                                     isChecked: false)

                let realm = try! Realm()
                do {
                    try realm.write {
                        realm.add(item)
                    }
                } catch {
                    print("Error while adding data: ", error)
                }
            }
        }
        
        //5. dodati poruku da su itemi uspesno dodati na to buy listu
    }
}

//MARK: - Helper f-ons

extension ViewRecipeViewController {
    
    func changeIsCheckedProperty(_ ingredientCell: IngredientCell) {
        if let i = ingredients.firstIndex(where: {$0.name == ingredientCell.ingredientLabel.text}){
            ingredients[i].isChecked.toggle()
        }
    }
}
