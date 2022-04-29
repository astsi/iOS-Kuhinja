//
//  UIView+CornerRadius.swift
//  iOS-Kuhinja
//
//  Created by Anastasija on 29.4.22..
//

import UIKit

extension UIView {
    func roundedCorners(radius: CGFloat) {
        layer.masksToBounds = true
        layer.cornerRadius = radius
    }
}
