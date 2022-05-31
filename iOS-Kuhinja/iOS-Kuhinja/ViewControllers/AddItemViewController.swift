//
//  AddItemViewController.swift
//  iOS-Kuhinja
//
//  Created by Anastasija on 19.4.22..
//

import UIKit
import RealmSwift

protocol AddItemViewControllerDelegate : AnyObject {
    
    func addItemViewController(_ controller: AddItemViewController, didCreate item: ItemToBuy)
    func editItemViewController(_ controller: AddItemViewController, didEdit item: ItemToBuy)
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
        initialValuesSetup()
    }
}

//MARK: UI

extension AddItemViewController {
    
    func initialValuesSetup() {
        initialFieldsSetup()
        initialFieldValues()
    }
    
    func initialFieldsSetup() {
        nameTextField.returnKeyType = .done
        nameTextField.autocapitalizationType = .words
        nameTextField.autocorrectionType = .no
        nameTextField.becomeFirstResponder()
        nameTextField.delegate = self
        
        formatter.dateFormat =  K.dateFormat
        colorButton.roundedCorners(radius: 4)
        colorButton.layer.borderWidth = 2
    }
    
    func initialFieldValues() {
        //initial Field Values:
        
        let colorHex = editedItem?.hexColor ?? "#808080"
        let currentDate = editedItem?.date ?? Date()
        let currentQuantity = editedItem?.amount ?? 10
        
        nameTextField.text = editedItem?.name ?? "Apple"
        importanceSegmentControl.selectedSegmentIndex = editedItem?.priority ?? 0
        datePicker.date = editedItem?.date ?? Date()
        colorButton.backgroundColor = UIColor(hexString: colorHex)
        quantitySlider.value = Float(currentQuantity)
        
        //ititial Preview Values:
        
        previewNameLabel.text = editedItem?.name
        previewImportanceLabel.text = displayPriorityTitle(priority: editedItem?.priority ?? 0)
        previewDateLabel.text = formatter.string(from: currentDate)
        previewColorView.backgroundColor = UIColor(hexString: colorHex)
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
        
        if previewNameLabel.text == nil {
            nameTextField.layer.borderWidth = 2
            nameTextField.layer.borderColor = .init(red: 1, green: 0, blue: 0, alpha: 1)
            nameTextField.wiggle()
            return
        }
                
        let item = ItemToBuy(
                        name: previewNameLabel.text ?? "Default item",
                        amount: Int (quantitySlider.value),
                        date: datePicker.date,
                        hexColor: previewColorView.backgroundColor?.toHex() ?? "#ffff00",
                        priority: importanceSegmentControl.selectedSegmentIndex,
                        isChecked: editedItem?.isChecked ?? false)
        
        if editedItem == nil {
            delegate?.addItemViewController(self, didCreate: item)
        }
        else {
            delegate?.editItemViewController(self, didEdit: item)
        }
    }
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
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 0
    }
}

