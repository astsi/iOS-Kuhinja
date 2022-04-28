//
//  AddItemViewController.swift
//  iOS-Kuhinja
//
//  Created by Anastasija on 19.4.22..
//

import UIKit

//TODO: Add Constraints, Modify nameTextField, implement Save button action

protocol AddItemViewControllerDelegate : AnyObject {
    
    func addItemViewController(_ controller: AddItemViewController, didCreate item: Item)
}

class AddItemViewController: UIViewController {

    // Adding Item part:
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var importanceSegmentControl: UISegmentedControl!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var colorButton: UIButton!
    @IBOutlet weak var quantitySlider: UISlider!
    
    // Preview Part:
    
    @IBOutlet weak var previewNameLabel: UILabel!
    @IBOutlet weak var previewImportanceLabel: UILabel!
    @IBOutlet weak var previewDateLabel: UILabel!
    @IBOutlet weak var previewColorView: UIView!
    @IBOutlet weak var previewQuantityLabel: UILabel!
    
    let formatter = DateFormatter()
    var priority = Priority.low
    var editedItem : Item?
    weak var delegate : AddItemViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //nameTextField setup:
        
        nameTextField.returnKeyType = .done
        nameTextField.autocapitalizationType = .words
        nameTextField.autocorrectionType = .no
        nameTextField.becomeFirstResponder()
        nameTextField.delegate = self
        
        //initial Field Values:
        formatter.dateFormat =  "dd.MM.yyyy. HH:mm"
        colorButton.tintColor = .systemOrange
        colorButton.backgroundColor = .systemOrange
        colorButton.roundedCorners(radius: 4)
        
        previewColorView.backgroundColor = .systemOrange
        previewDateLabel.text = formatter.string(from: Date())
        previewQuantityLabel.text = "x 10"
        previewImportanceLabel.text = importanceSegmentControl.titleForSegment(at: 0)
    }
    
    @IBAction func onChangedImportance(_ sender: UISegmentedControl) {
        let segmentIndex = sender.selectedSegmentIndex
        if segmentIndex == 2 {
            previewImportanceLabel.textColor = .systemRed
            priority = .high
        }
        else {
            previewImportanceLabel.textColor = .black
            priority = (segmentIndex == 0) ? .low : .medium
        }
        previewImportanceLabel.text = sender.titleForSegment(at: segmentIndex)
    }
    
    @IBAction func didTouchDateTime(_ sender: UIDatePicker) {
        
        let myString = formatter.string(from: sender.date)
        previewDateLabel.text = myString
    }
    
        
    @IBAction func didTouchPickColor(_ sender: UIButton) {
        //colorPicker setup:
        
     let colorPickerVC = UIColorPickerViewController()
        colorPickerVC.delegate = self
        present(colorPickerVC, animated: true)
    }
    
    @IBAction func onChangedQuantity(_ sender: UISlider) {
        previewQuantityLabel.text = "x "
        let textValue = String (Int(sender.value))
        previewQuantityLabel.text?.append(contentsOf: textValue)
    }
    
    
    @IBAction func didTouchSaveButton(_ sender: UIBarButtonItem) {
        
        //Check if all the fields have values
        //Error messages if they dont
        let item = Item(uuid: editedItem?.uuid ?? .init(),
                        name: previewNameLabel.text!,
                        amount: Int (quantitySlider.value),
                        date: datePicker.date,
                        color: previewColorView.backgroundColor ?? .systemGray,
                        priority: self.priority)
        
        delegate?.addItemViewController(self, didCreate: item)
        
//        let toBuyVC = ToBuyViewController()
//
//        DispatchQueue.main.async {
//            toBuyVC.itemList.append(item)
//            //toBuyVC.tableView.reloadData()
//        }
//        navigationController?.popViewController(animated: true)
//        //performSegue(withIdentifier: "toBuy", sender: self)
    }
    
}
//neposredno pre nego sto se otvori novi screen, doda se item u listu iz To Buy View Controlera
extension AddItemViewController: UIColorPickerViewControllerDelegate {

    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        let color = viewController.selectedColor
        colorButton.tintColor = color
        previewColorView.backgroundColor = color
    }
}

extension AddItemViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if let text = textField.text {
            previewNameLabel.text = text
        }
        return true
    }
}

