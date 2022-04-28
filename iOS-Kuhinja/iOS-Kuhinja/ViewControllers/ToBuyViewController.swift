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
    
//    public var itemList : [Item] = []
    
    
    var itemList : [Item] = [Item(uuid: .init() ,name: "Milk", amount: 10, date: Date(), color: .green, priority: .medium),
                             Item(uuid: .init(), name: "Onion", amount: 25, date: Date(), color: .cyan, priority: .high)]
    private var selectedItem : Item?
    
    let formatter = DateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(.init(nibName: "ToBuyCell", bundle: nil), forCellReuseIdentifier: "ToBuyCell")
        formatter.dateFormat =  "dd.MM.yyyy. HH:mm"

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "plusNavButtonTouched", let controller = segue.destination as? AddItemViewController {
            controller.delegate = self
            
        }
        
        if segue.identifier == "editGroceryItem", let controller = segue.destination as? AddItemViewController {
            controller.delegate = self
            controller.editedItem = selectedItem
        }
            
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        if itemList.isEmpty {
            tableView.isHidden = true //TODO: Hide the + bar button
        } else {
            //emptyListView.isHidden = true - nema potrebe da se pise, tabela se kreira preko celog ekrana bez obzira na br. item-a u njoj
        }
    }
}

//MARK: Extensions

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
        cell.dateLabel.text = formatter.string(from: item.date)
        cell.importanceLabel.text = item.priority.displayTitle
        cell.checkImage.isHidden = !item.isChecked
        
        return cell
        
    }
}

extension ToBuyViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ToBuyCell.height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedItem = itemList[indexPath.row]
        performSegue(withIdentifier: "editGroceryItem", sender: self)
        
    }
    
}

extension ToBuyViewController: AddItemViewControllerDelegate {
    func addItemViewController(_ controller: AddItemViewController, didCreate item: Item) {
        if let index = itemList.firstIndex(where: { listItem in
            listItem.uuid == item.uuid
        }) {
            itemList[index] = item
            
        } else {
            itemList.append(item)

        }
        tableView.reloadData()
        navigationController?.popViewController(animated: true)
    }
    
    
    
}
