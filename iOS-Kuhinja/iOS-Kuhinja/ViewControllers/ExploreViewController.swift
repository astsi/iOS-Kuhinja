//
//  ExploreViewController.swift
//  iOS-Kuhinja
//
//  Created by Anastasija on 19.4.22..
//

import UIKit
import SwiftUI
import RealmSwift

class ExploreViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var recipeNetworking = RecipeNetworking.shared
    var comments:[Person] = []
}

//MARK: - LifeCycle

extension ExploreViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recipeNetworking.delegate = self
        recipeNetworking.fetchRecipe(mainIngredient: "pizza")
        
        DecodeJsonComments()
        
        tableView.register(SocialChefCell.nib(), forCellReuseIdentifier: K.commentCell)
        imageView.roundedCorners(radius: 8)
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
        
        cell.config(image: UIImage(named: EditCommentImageString(comment.profileImageUrl)) ?? UIImage(),
                    comment: comment.comment,
                    timeAgo: comment.timestamp)
        
        return cell
    }
}

extension ExploreViewController: RecipeNetworkingDelegate {
    
    func didUpdateRecipe(_ recipeNetworking: RecipeNetworking, recipe: Recipe) {
        DispatchQueue.main.async {
            self.recipeNetworking = recipeNetworking
            self.activityIndicator.stopAnimating()
            self.imageView.image = recipe.image.loadImage()
        }
    }
    
    func didUpdateRecipes(_ recipeNetworking: RecipeNetworking, recipes: [Recipe]) {
        
    }
}

//MARK: - JSONData

extension ExploreViewController {
    
    func DecodeJsonComments(){
        guard let jsonURL = Bundle(for: type(of: self)).path(forResource: "sample_friends_feed", ofType: "json") else {
            return
        }
        guard let jsonString = try? String(contentsOf: URL(fileURLWithPath: jsonURL), encoding: String.Encoding.utf8) else {
            return
        }
        var commentsData: CommentsData?
        
        do {
            commentsData = try JSONDecoder().decode(CommentsData.self, from: Data(jsonString.utf8))
        } catch {
            print ("Error while decoding data.")
        }
        
        guard let result = commentsData else {
            return
        }
        comments = result.feed
        
        for person in result.feed {
            comments.append(person)
        }
    }
    
    func EditCommentImageString(_ imageString: String) -> String {
        let str = imageString.split(separator: "/").last?.split(separator: ".").first
        return String(str ?? "")
    }
}
