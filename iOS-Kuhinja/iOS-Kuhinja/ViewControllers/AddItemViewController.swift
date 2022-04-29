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
    //var priority = Priority.low
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
        
        formatter.dateFormat =  "dd.MM.yyyy. HH:mm"
        colorButton.roundedCorners(radius: 4)
        let currentDate = editedItem?.date ?? Date()
        let currentQuantity = editedItem?.amount ?? 10
        
        //initial Field Values:
        nameTextField.text = editedItem?.name ?? "Apple"
        importanceSegmentControl.selectedSegmentIndex = editedItem?.priority.displayIndex ?? 0
        datePicker.date = editedItem?.date ?? Date()
        colorButton.backgroundColor = editedItem?.color ?? .systemOrange
        
        quantitySlider.value = Float(currentQuantity)
        
        //ititial Preview Values:
        previewNameLabel.text = editedItem?.name
        previewImportanceLabel.text = editedItem?.priority.displayTitle ?? importanceSegmentControl.titleForSegment(at: 0)
        previewDateLabel.text = formatter.string(from: currentDate)
        previewColorView.backgroundColor = editedItem?.color ?? .systemOrange
        previewQuantityLabel.text =  String(currentQuantity)
        
        
    }
    
    @IBAction func onChangedImportance(_ sender: UISegmentedControl) {
        let segmentIndex = sender.selectedSegmentIndex
        if segmentIndex == 2 {
            previewImportanceLabel.textColor = .systemRed
            //priority = .high
        }
        else {
            previewImportanceLabel.textColor = .black
            //priority = (segmentIndex == 0) ? .low : .medium
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
        
        //TODO: Check if all the fields have values
        //Error messages if they dont
        let item = Item(uuid: editedItem?.uuid ?? .init(),
                        name: previewNameLabel.text!,
                        amount: Int (quantitySlider.value),
                        date: datePicker.date,
                        color: previewColorView.backgroundColor ?? .systemGray,
                        priority: (importanceSegmentControl.selectedSegmentIndex == 0) ? .low : (importanceSegmentControl.selectedSegmentIndex == 1) ? .medium : .high,
                        isChecked: editedItem?.isChecked ?? false)
                        
        delegate?.addItemViewController(self, didCreate: item)
        
    }
    
}
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



