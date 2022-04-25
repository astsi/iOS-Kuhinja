//
//  AddItemViewController.swift
//  iOS-Kuhinja
//
//  Created by Anastasija on 19.4.22..
//

import UIKit

class AddItemViewController: UIViewController {

    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var dateTimeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func didTouchPickDate(_ sender: Any) {
        
        //let picker
    }
    
    
    @IBAction func didTouchPickColor(_ sender: UIButton) {
     let colorPickerVC = UIColorPickerViewController()
        colorPickerVC.delegate = self
        present(colorPickerVC, animated: true)
    }
}

extension AddItemViewController: UIColorPickerViewControllerDelegate {

    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        let color = viewController.selectedColor
        colorView.backgroundColor = color
    }
}
