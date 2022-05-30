//
//  UITextField+Wiggle.swift
//  iOS-Kuhinja
//
//  Created by Anastasija on 30.5.22..
//

import Foundation
import UIKit

extension UITextField {
    
    func wiggle() {
        let wiggleAnim = CABasicAnimation(keyPath: "position")
        wiggleAnim.duration = 0.05
        wiggleAnim.repeatCount = 5
        wiggleAnim.autoreverses = true //make it reverse in the oposite way
        wiggleAnim.fromValue = CGPoint(x: self.center.x - 4.0, y: self.center.y)
        wiggleAnim.toValue = CGPoint(x:self.center.x + 4.0, y: self.center.y)
        layer.add(wiggleAnim, forKey: "position") //to add the animation to the textField
    }
}
