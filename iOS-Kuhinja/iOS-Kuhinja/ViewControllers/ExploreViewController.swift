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
    
    let comments = [Comment(image: UIImage(named: "chef")!, comment: "Tasty!", timeAge: 10),
                    Comment(image: UIImage(named: "chef")!, comment: "Amazing!", timeAge: 20)]
}

//MARK: - LifeCycle

extension ExploreViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cellIdentifier = "SocialChefCell"
        tableView.register(SocialChefCell.nib(), forCellReuseIdentifier: cellIdentifier)
        
        imageView.image = UIImage(named: "pasta")
    }
}

//MARK: - TableView

extension ExploreViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let comment = comments[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "SocialChefCell", for: indexPath) as! SocialChefCell
        cell.config(image: comment.image, comment: comment.comment, timeAgo: comment.timeAge)
        
        return cell
    }
}

extension ExploreViewController: UITableViewDelegate {
    
}
