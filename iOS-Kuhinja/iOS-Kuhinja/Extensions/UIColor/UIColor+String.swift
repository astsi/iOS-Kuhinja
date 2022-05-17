//
//  UIColor+String.swift
//  iOS-Kuhinja
//
//  Created by Anastasija on 16.5.22..
//

import UIKit

public extension UIColor {

    class func StringFromUIColor(color: UIColor) -> String {
        let colorRef = color.cgColor
        return CIColor(cgColor: colorRef).stringRepresentation
    }
    
//    class func UIColorFromString(string: String) -> UIColor {
//        let color = CIColor().
//    }
    
}
