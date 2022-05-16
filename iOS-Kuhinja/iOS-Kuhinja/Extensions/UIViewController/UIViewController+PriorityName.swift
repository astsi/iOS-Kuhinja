//
//  UIViewController+PriorityName.swift
//  iOS-Kuhinja
//
//  Created by Anastasija on 16.5.22..
//

import UIKit

extension UIViewController {
    
    func displayPriorityTitle(priority: Int) -> String {
    
        return (priority == 2) ? "high" : (priority == 1) ? "medium" : "low"
    }
}
