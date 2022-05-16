//
//  AddItemViewController.swift
//  iOS-Kuhinja
//
//  Created by Anastasija on 19.4.22..
//

import UIKit
import RealmSwift

//TODO: Add Constraints, Modify nameTextField

protocol AddItemViewControllerDelegate : AnyObject {
    
    func addItemViewController(_ controller: AddItemViewController, didCreate item: ItemToBuy)
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
    var editedItem : ItemToBuy?
    weak var delegate : AddItemViewControllerDelegate?
    
}

//MARK: - Lifecycle
extension AddItemViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //nameTextField setup:
        
        nameTextField.returnKeyType = .done
        nameTextField.autocapitalizationType = .words
        nameTextField.autocorrectionType = .no
        nameTextField.becomeFirstResponder()
        nameTextField.delegate = self
        
        formatter.dateFormat =  K.dateFormat
        colorButton.roundedCorners(radius: 4)
        let currentDate = editedItem?.date ?? Date()
        let currentQuantity = editedItem?.amount ?? 10
        
        //initial Field Values:
        
        nameTextField.text = editedItem?.name ?? "Apple"
        importanceSegmentControl.selectedSegmentIndex = editedItem?.priority ?? 0
        datePicker.date = editedItem?.date ?? Date()
        colorButton.backgroundColor = editedItem?.color ?? .systemOrange
        quantitySlider.value = Float(currentQuantity)
        
        //ititial Preview Values:
        
        previewNameLabel.text = editedItem?.name
        previewImportanceLabel.text = displayPriorityTitle(priority: editedItem?.priority ?? 0)
        previewDateLabel.text = formatter.string(from: currentDate)
        previewColorView.backgroundColor = editedItem?.color ?? .systemOrange
        previewQuantityLabel.text =  String(currentQuantity)
        
        
    }
}

//MARK: - Actions
extension AddItemViewController {
    
    @IBAction func onChangedImportance(_ sender: UISegmentedControl) {
        let segmentIndex = sender.selectedSegmentIndex
        previewImportanceLabel.textColor = (segmentIndex == 2) ? .systemRed : .black
        previewImportanceLabel.text = sender.titleForSegment(at: segmentIndex)
    }
    
    @IBAction func didTouchDateTime(_ sender: UIDatePicker) {
        let myString = formatter.string(from: sender.date)
        previewDateLabel.text = myString
    }
    
        
    @IBAction func didTouchPickColor(_ sender: UIButton) {
     let colorPickerVC = UIColorPickerViewController()
        colorPickerVC.delegate = self
        present(colorPickerVC, animated: true)
    }
    
    @IBAction func onChangedQuantity(_ sender: UISlider) {
        previewQuantityLabel.text = String (Int(sender.value))
    }
    
    @IBAction func didTouchSaveButton(_ sender: UIBarButtonItem) {
        
        //TODO: Check if all the fields have values, error messages if they don't
        
        let item = ItemToBuy(uuid: editedItem?.uuid ?? .init(),
                        name: previewNameLabel.text!,
                        amount: Int (quantitySlider.value),
                        date: datePicker.date,
                        color: previewColorView.backgroundColor ?? .systemGray,
                        priority: importanceSegmentControl.selectedSegmentIndex,
                        isChecked: editedItem?.isChecked ?? false)
        
        delegate?.addItemViewController(self, didCreate: item)
        
    }
}

//MARK: - Realm
extension AddItemViewController {
    
}

//MARK: - Delegates
extension AddItemViewController: UIColorPickerViewControllerDelegate {

    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        let color = viewController.selectedColor
        colorButton.backgroundColor = color
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


