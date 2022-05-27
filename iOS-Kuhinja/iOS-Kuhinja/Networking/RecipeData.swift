//
//  RecipeData.swift
//  iOS-Kuhinja
//
//  Created by Anastasija on 24.5.22..
//

import Foundation
import UIKit

protocol DisplayRecipe {
    
    var name: String { get }
    var foodImage: String { get }
    var time: Int { get }
    var ingredients: [String] { get }
    var kcal: String { get }
}

struct RecipeData: Codable {
    
    let hits: [Hits]
}

struct Hits: Codable {

    let recipe: Recipe
}

struct Recipe: Codable {

    let label: String
    let image: String
    let totalTime: Int
    let ingredientLines: [String]
    let calories: Double
}

extension Recipe: DisplayRecipe {
    var name: String {
        label
    }
    
    var foodImage: String {
        image
    }
    
    var time: Int {
        totalTime
    }
    
    var ingredients: [String] {
        ingredientLines
    }
    
    var kcal: String {
        String(format: "%.2f", calories)
    }
    
    
}
