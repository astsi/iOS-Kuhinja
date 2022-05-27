//
//  ViewRecipeViewController.swift
//  iOS-Kuhinja
//
//  Created by Anastasija on 19.4.22..
//

import UIKit

class ViewRecipeViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var kcalLabel: UILabel!
    @IBOutlet weak var ingredientsTableView: UITableView!
    
    weak var delegate: UIViewController?
    var recipe: Recipe?
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
        print(ingredient)
        let cell = tableView.dequeueReusableCell(withIdentifier: K.ingredientCell, for: indexPath) as! IngredientCell
        cell.config(ingredient)
        return cell
    }
}
