//
//  ViewRecipeViewController.swift
//  iOS-Kuhinja
//
//  Created by Anastasija on 19.4.22..
//

import UIKit

// da li cuvati podatke u toku jednog dana u Realm-u ili ih azurirati pri svakom koriscenju aplikacije
class ViewRecipeViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var kcalLabel: UILabel!
    @IBOutlet weak var proteinLabel: UILabel!
    @IBOutlet weak var fatLabel: UILabel!
    @IBOutlet weak var carbLabel: UILabel!

    weak var delegate: UIViewController?
}

// MARK: - LifeCycle
extension ViewRecipeViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

