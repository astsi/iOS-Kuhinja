//
//  ToBuyViewController.swift
//  iOS-Kuhinja
//
//  Created by Anastasija on 19.4.22..
//

import UIKit
import RealmSwift

class ToBuyViewController: UIViewController {

    @IBOutlet weak var addItemButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyListView: UIView!
    
    private var itemList: Results<ItemToBuy>?
    private let formatter = DateFormatter()
    private var selectedItem : ItemToBuy?
    
    //Realm setup:
    
    let realm = try! Realm()
}

// MARK: - Lifecycles

extension ToBuyViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupActions()
        readItems()
        
        //Uncomment the next line to find the realm config path
        //print(realm.configuration.fileURL!)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        hideTableViewIfNeeded()
        tableView.reloadData()
    }
}

// MARK: - UI

extension ToBuyViewController {
    
    func setupUI() {
        setupTableView()
    }
    
    func setupTableView() {
        tableView.register(.init(nibName: K.itemCell, bundle: nil), forCellReuseIdentifier: K.itemCell)
    }
    
    func hideTableViewIfNeeded() {
        if itemList == nil || itemList?.count == 0 {
            tableView.isHidden = true
        } else {
            tableView.isHidden = false
        }
    }
}

// MARK: - Actions

extension ToBuyViewController {
    
    func setupActions() {
        setupFormatter()
    }
    
    func setupFormatter() {
        formatter.dateFormat =  K.dateFormat
    }
}

//MARK: - TableViewDataSource

extension ToBuyViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.itemCell, for: indexPath) as! ToBuyCell
        if let item = itemList?[indexPath.row]{
            fillCell(cell, item)
        }
        cell.delegate = self
        return cell
    }
        
    func fillCell(_ cell: ToBuyCell,_ item: ItemToBuy) {
        cell.config(name: item.name ?? "",
                    importance: item.priority,
                    date: item.date,
                    color: item.hexColor,
                    amount: item.amount,
                    isChecked: item.isChecked)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            if let item = itemList?[indexPath.row] {
                do {
                    try realm.write{
                        realm.delete(item)
                    }
                } catch {
                    print ("Error while deleting data: ", error)
                }
            }
            
            hideTableViewIfNeeded()
            tableView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
}

// MARK: - TableViewDelegate

extension ToBuyViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ToBuyCell.height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedItem = itemList![indexPath.row]
        performSegue(withIdentifier: K.goToEditItem, sender: self)
    }
}

//MARK: - Realm

extension ToBuyViewController {
    
    func addItem(itemToBuy: ItemToBuy) {
        
        do {
            try realm.write {
                realm.add(itemToBuy)
            }
        } catch {
            print("Error while adding data: ", error)
        }
    }
    
    func readItems() {
        itemList = realm.objects(ItemToBuy.self)
    }
}

// MARK: - Delegates

extension ToBuyViewController: AddItemViewControllerDelegate {
    
    func editItemViewController(_ controller: AddItemViewController, didEdit item: ItemToBuy) {
        let realm = try! Realm()
        let objects = realm.objects(ItemToBuy.self).filter { $0._id == item._id}
        let object = objects[0]
        
        do {
            try realm.write {
                object.name = item.name
                object.amount = item.amount
                object.hexColor = item.hexColor
                object.date = item.date
                object.isChecked = item.isChecked
            }
        } catch {
            print ("Error while editing item: ", error)
        }
               
        tableView.reloadData()
        navigationController?.popViewController(animated: true)
    
    }
    
    func addItemViewController(_ controller: AddItemViewController, didCreate item: ItemToBuy) {
        let realm = try! Realm()
        
        do {
            try realm.write {
                realm.add(item)
            }
        } catch {
            print("Error while adding data: ", error)
        }
        
        tableView.reloadData()
        navigationController?.popViewController(animated: true)
    }
}

extension ToBuyViewController: ToBuyCellDelegate {
    
    func toBuyCell(_ toBuyCell: ToBuyCell, didChangeCheckedState isChecked: Bool) {
        if let indexPath = tableView.indexPath(for: toBuyCell){
            if let item = itemList?[indexPath.row] {
                do {
                    try realm.write{
                        item.isChecked = !isChecked
                        toBuyCell.checkImage.isHidden.toggle()
                    }
                } catch {
                    print("Error while editing item: ", error)
                }
            }
        }
    }
}

// MARK: Navigation

extension ToBuyViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.goToAddItem, let controller = segue.destination as? AddItemViewController {
            controller.delegate = self
        }
        
        if segue.identifier == K.goToEditItem, let controller = segue.destination as? AddItemViewController {
            controller.delegate = self
            controller.editedItem = selectedItem
        }
    }
}
