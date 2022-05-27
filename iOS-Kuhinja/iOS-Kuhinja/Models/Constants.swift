//
//  Constants.swift
//  iOS-Kuhinja
//
//  Created by Anastasija on 9.5.22..
//

import Foundation

public struct K {
    
    //MARK: - Cells
    
    static let recipeCell = "RecipeCell"
    static let itemCell = "ToBuyCell"
    static let commentCell = "SocialChefCell"
    static let ingredientCell = "IngredientCell"
    
    //MARK: - Segues
    
    static let goToExplore = "GoToExplore"
    static let goToViewRecipe = "GoToViewRecipe"
    static let goToAddItem = "GoToAddItem"
    static let goToEditItem = "GoToEditItem"
    
    //MARK: - Formats
    
    static let dateFormat = "dd.MM.yyyy. HH:mm"
    
    //MARK: - Recipe Networking
    
    static let recipeUrl = "https://api.edamam.com/api/recipes/v2?type=public"
    static let appId = "912244f4"
    static let appKey = "8536e16635340655d2ef41b96a0d7b00"
    
}
