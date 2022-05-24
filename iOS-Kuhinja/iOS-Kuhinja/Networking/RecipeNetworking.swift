//
//  RecipeNetworking.swift
//  iOS-Kuhinja
//
//  Created by Anastasija on 24.5.22..
//

import UIKit
import Alamofire

protocol RecipeNetworkingDelegate {
    func didUpdateRecipes(_ recipeNetworking: RecipeNetworking, recipe: RecipeModel)
}

struct RecipeNetworking {
    
    let RecipeUrl = "https://api.edamam.com/api/recipes/v2?type=public"
    let appId = "912244f4"
    let appKey = "8536e16635340655d2ef41b96a0d7b00"
    
    var delegate: RecipeNetworkingDelegate?
    
    
    func fetchRecipe( mainIngredient: String){
        var url = RecipeUrl
        url.append(contentsOf: "&app_key=\(appKey)")
        url.append(contentsOf: "&app_id=\(appId)")
        url.append(contentsOf: "&q=\(mainIngredient)")
        url.append(contentsOf: "&random=true&time=1-360")
        
        performRequest(url)
    }
    
    func performRequest(_ urlString: String){
        if let url = URL(string: urlString) {
            AF.request(url)
                .validate()
                .responseDecodable(of: RecipeData.self) { (response) in
                    guard let recipe = response.value
                    else {
                        print("Networking Error")
                        return
                    }
                    let recipeName = recipe.hits[0].recipe.label
                    let recipeImage = recipe.hits[0].recipe.image
                    let recipeModel = RecipeModel(name: recipeName, image: recipeImage.loadImage())
                    
                    print(recipe.hits[0].recipe.label)
                    self.delegate?.didUpdateRecipes(self, recipe: recipeModel)
                }
        }
    }
}
