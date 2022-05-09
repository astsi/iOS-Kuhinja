//
//  RecipesViewController.swift
//  iOS-Kuhinja
//
//  Created by Anastasija on 19.4.22..
//

import UIKit

class RecipesViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    
    let recipes : [Recipe] = [Recipe(image: UIImage(named: K.pastaBolognese)!, name: "Bolognese", timeNeeded: 35),
                              Recipe(image: UIImage(named: K.pastaCarbonara)!, name: "Carbonara", timeNeeded: 25)]
}

//MARK: - LifeCycle

extension RecipesViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 204, height: 204)
        collectionView.collectionViewLayout = layout
        
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
        cell.configure(image: recipes[indexPath.row].image, name: recipes[indexPath.row].name, neededTime: recipes[indexPath.row].timeNeeded)
        
        return cell
    }
}

extension RecipesViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        performSegue(withIdentifier: K.goToViewRecipe, sender: self)
    }
}

extension RecipesViewController : UICollectionViewDelegateFlowLayout {
    
     //TODO: specify the margin and padding between cells here
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 204, height: 204)
    }
}

// MARK: - Navigation

extension RecipesViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.goToViewRecipe, let controller = segue.destination as? ViewRecipeViewController {
            controller.delegate = self
        }
    }
}
