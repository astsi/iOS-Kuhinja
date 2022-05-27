//
//  RecipesViewController.swift
//  iOS-Kuhinja
//
//  Created by Anastasija on 19.4.22..
//

import UIKit

class RecipesViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    
    var recipeNetworking = RecipeNetworking.shared
    var recipes: [Recipe] = []
    var selectedRecipe: Recipe?
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
}

//MARK: - LifeCycle

extension RecipesViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNetworking()
        setupUI()
        setupTableViewCell()
    }
}

//MARK: - Initial setup

extension RecipesViewController {
    func setupUI() {
        setupLayout()
    }
    
    func setupNetworking() {
        recipeNetworking.delegate = self
        recipeNetworking.fetchRecipes(mainIngredient: "pasta")
    }
    
    func setupLayout() {
        let layout = UICollectionViewFlowLayout()
        collectionView.collectionViewLayout = layout
    }
    
    func setupTableViewCell() {
        let cellIdentifier = K.recipeCell
        collectionView.register(RecipeCell.nib(), forCellWithReuseIdentifier: cellIdentifier)
    }
}

//MARK: - UICollectionView

extension RecipesViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.recipeCell, for: indexPath) as! RecipeCell
        cell.config(image: recipes[indexPath.row].image.loadImage(), name: recipes[indexPath.row].name, neededTime: recipes[indexPath.row].time)
        
        return cell
    }
}

extension RecipesViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        selectedRecipe = recipes[indexPath.row]
        performSegue(withIdentifier: K.goToViewRecipe, sender: self)
    }
}

extension RecipesViewController : UICollectionViewDelegateFlowLayout {
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = view.bounds.size.width / 2 - 10
        return CGSize(width: size, height: size)
    }
}

// MARK: - Navigation

extension RecipesViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.goToViewRecipe, let controller = segue.destination as? ViewRecipeViewController {
            controller.delegate = self
            controller.recipe = selectedRecipe
        }
    }
}

//MARK: - NetworkingDelegate

extension RecipesViewController: RecipeNetworkingDelegate {
    func didUpdateRecipe(_ recipeNetworking: RecipeNetworking, recipe: Recipe) {

    }

    func didUpdateRecipes(_ recipeNetworking: RecipeNetworking, recipes: [Recipe]) {

        DispatchQueue.main.async {
            self.recipeNetworking = recipeNetworking
            self.recipes.append(contentsOf: recipes)
            self.activityIndicator.stopAnimating()
            self.collectionView.reloadData()
        }
    }
}
