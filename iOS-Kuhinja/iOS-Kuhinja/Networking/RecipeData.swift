//
//  RecipeData.swift
//  iOS-Kuhinja
//
//  Created by Anastasija on 24.5.22..
//

import Foundation

struct RecipeData: Codable {
    
    let hits: [Hits]
}

struct Hits: Codable {
    
    let recipe: Recipe
}
//hits[0].recipe.ingredientLines
struct Recipe: Codable {

    let label: String
    let image: String
    let ingredientLines: [String]
}
