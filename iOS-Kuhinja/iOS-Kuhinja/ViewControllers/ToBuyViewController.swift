//
//  ToBuyViewController.swift
//  iOS-Kuhinja
//
//  Created by Anastasija on 19.4.22..
//

import UIKit

class ToBuyViewController: UIViewController {

    @IBOutlet weak var addItemButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyListView: UIView!
    
    var itemList : [Item] = []
//    var itemList : [Item] = [Item(name: "Milk", amount: 5, color: .green),
//                             Item(name: "Carrot", amount: 22, color: .purple)]
//
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(.init(nibName: "ToBuyCell", bundle: nil), forCellReuseIdentifier: "ToBuyCell")

    }
    
    override func viewDidAppear(_ animated: Bool) {
        if itemList.isEmpty {
            tableView.isHidden = true //TODO: Hide the + bar button
        } else {
            //emptyListView.isHidden = true - nema potrebe da se pise, tabela se kreira preko celog ekrana bez obzira na br. item-a u njoj
        }
    }

    @IBAction func onAddItem(_ sender: UIBarButtonItem) {
    }
}

extension ToBuyViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = itemList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToBuyCell", for: indexPath) as! ToBuyCell
        cell.nameLabel.text = item.name
        cell.colorView.backgroundColor = item.color
        cell.amountLabel.text = String(item.amount)
        return cell
        
    }
}

extension ToBuyViewController: UITableViewDelegate {
    
}
