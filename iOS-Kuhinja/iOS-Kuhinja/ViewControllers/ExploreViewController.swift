//
//  ExploreViewController.swift
//  iOS-Kuhinja
//
//  Created by Anastasija on 19.4.22..
//

import UIKit

class ExploreViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var recipeNetworking = RecipeNetworking()
    
    let comments = [Comment(image: UIImage(named: "chef")!, comment: "Tasty!", timeAgo: 10),
                    Comment(image: UIImage(named: "chef")!, comment: "Amazing!", timeAgo: 20),
                    Comment(image: UIImage(named: "chef")!, comment: "Amazing!", timeAgo: 20),
                    Comment(image: UIImage(named: "chef")!, comment: "Amazing!", timeAgo: 20),
                    Comment(image: UIImage(named: "chef")!, comment: "Amazing!", timeAgo: 20),
                    Comment(image: UIImage(named: "chef")!, comment: "Amazing!", timeAgo: 20),
                    Comment(image: UIImage(named: "chef")!, comment: "Amazing!", timeAgo: 20),
                    Comment(image: UIImage(named: "chef")!, comment: "Amazing!", timeAgo: 20),
                    Comment(image: UIImage(named: "chef")!, comment: "Amazing!", timeAgo: 20)]
}

//MARK: - LifeCycle

extension ExploreViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recipeNetworking.delegate = self
        recipeNetworking.fetchRecipe(mainIngredient: "pizza")
    
        
        tableView.register(SocialChefCell.nib(), forCellReuseIdentifier: K.commentCell)
        imageView.image = UIImage(named: K.pastaImage)
        imageView.roundedCorners(radius: 8)
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
}

//MARK: - TableView

extension ExploreViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let comment = comments[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: K.commentCell, for: indexPath) as! SocialChefCell
        cell.config(image: comment.image, comment: comment.comment, timeAgo: comment.timeAgo)
        
        return cell
    }
}

extension ExploreViewController: UITableViewDelegate {
    
}

extension ExploreViewController: RecipeNetworkingDelegate {
    func didUpdateRecipes(_ recipeNetworking: RecipeNetworking, recipe: RecipeModel) {
        DispatchQueue.main.async {
            self.recipeNetworking = recipeNetworking
            self.imageView.image = recipe.image
        }
    }
    
    
}
