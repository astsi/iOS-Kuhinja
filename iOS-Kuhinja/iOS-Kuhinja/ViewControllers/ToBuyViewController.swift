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
    
    private var itemList : [Item] = [
        Item(uuid: .init() ,name: "Milk", amount: 10, date: Date(), color: .green, priority: .medium),
        Item(uuid: .init(), name: "Onion", amount: 25, date: Date(), color: .cyan, priority: .high)
    ]
    
    private let formatter = DateFormatter()
    private var selectedItem : Item?
}

// MARK: - Lifecycles

extension ToBuyViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupActions()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        hideTableViewIfNeeded()
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
        if itemList.isEmpty {
            tableView.isHidden = true
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
        return itemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = itemList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: K.itemCell, for: indexPath) as! ToBuyCell
        fillCell(cell, item)
        cell.delegate = self
        return cell
    }
    
    func fillCell(_ cell: ToBuyCell,_ item: Item) {
        cell.nameLabel.text = item.name
        cell.colorView.backgroundColor = item.color
        cell.amountLabel.text = String(item.amount)
        cell.dateLabel.text = formatter.string(from: item.date)
        cell.importanceLabel.text = item.priority.displayTitle
        cell.importanceLabel.textColor = (item.priority == .high) ? .systemRed : .black
        cell.checkImage.isHidden = !item.isChecked
    }
}

// MARK: - TableViewDelegate

extension ToBuyViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ToBuyCell.height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedItem = itemList[indexPath.row]
        performSegue(withIdentifier: K.goToEditItem, sender: self)
    }
}

// MARK: - Delegates

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

extension ToBuyViewController: ToBuyCellDelegate {
    
    func toBuyCell(_ toBuyCell: ToBuyCell, didChangeCheckedState isChecked: Bool) {
        if let indexPath = tableView.indexPath(for: toBuyCell){
            toBuyCell.checkImage.isHidden.toggle()
            itemList[indexPath.row].isChecked = !isChecked
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
