//
//  RecipeNetworking.swift
//  iOS-Kuhinja
//
//  Created by Anastasija on 24.5.22..
//

import UIKit
import Alamofire

protocol RecipeNetworkingDelegate: AnyObject {
    func didUpdateRecipe(_ recipeNetworking: RecipeNetworking, recipe: Recipe)
    func didUpdateRecipes(_ recipeNetworking: RecipeNetworking, recipes: [Recipe])
}

class RecipeNetworking {
 
    static var shared: RecipeNetworking = RecipeNetworking()

    //MARK: - Networking
    
    weak var delegate: RecipeNetworkingDelegate?
    
    private init(){
        
    }
    
    func fetchRecipe( mainIngredient: String){
        let url = createUrlString(mainIngredient)
        performRequest(url, multipleRecipes: false)
    }
    
    func fetchRecipes( mainIngredient: String) {
        let url = createUrlString(mainIngredient)
        performRequest(url, multipleRecipes: true)
    }
    
    func performRequest(_ urlString: String, multipleRecipes: Bool){
        if let url = URL(string: urlString) {
            AF.request(url)
                .validate()
                .responseDecodable(of: RecipeData.self) { (response) in
                    guard let recipeItems = response.value
                    else {
                        print("Networking Error")
                        return
                    }
                    self.recipeSetup(recipes: recipeItems.hits, multipleRecipes)
                }
        }
    }
    
    //MARK: - Helper f-ons
    
    func createUrlString(_ mainIngredient: String) -> String{
        var url = K.recipeUrl
        url.append(contentsOf: "&app_key=\(K.appKey)")
        url.append(contentsOf: "&app_id=\(K.appId)")
        url.append(contentsOf: "&q=\(mainIngredient)")
        url.append(contentsOf: "&random=true&time=1-360")
        
        return url
    }
    
    func recipeSetup(recipes: [Hits],_ multipleRecipes: Bool) {
        var recipeModel = Recipe(label: recipes[0].recipe.label,
                                 image: recipes[0].recipe.image,
                                 totalTime: recipes[0].recipe.totalTime,
                                 ingredientLines: recipes[0].recipe.ingredientLines,
                                 calories: recipes[0].recipe.calories)
        if multipleRecipes {
            var recipeModels: [Recipe] = []
            for recipeItem in recipes {
                recipeModel = Recipe(label: recipeItem.recipe.label,
                                     image: recipeItem.recipe.image,
                                     totalTime: recipeItem.recipe.totalTime,
                                     ingredientLines: recipeItem.recipe.ingredientLines,
                                     calories: recipeItem.recipe.calories)
                recipeModels.append(recipeModel)
            }
            
            self.delegate?.didUpdateRecipes(self, recipes: recipeModels)
        } else {
            self.delegate?.didUpdateRecipe(self, recipe: recipeModel)
        }
    }
}
