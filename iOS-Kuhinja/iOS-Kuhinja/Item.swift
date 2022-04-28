//
//  Item.swift
//  iOS-Kuhinja
//
//  Created by Anastasija on 21.4.22..
//

import Foundation
import UIKit

public struct Item {
    
    var uuid: UUID
    var name: String
    var amount: Int
    var date: Date
    var color: UIColor
    var priority: Priority
    var isChecked: Bool = false
}

public enum Priority : String {
    case low, medium, high
    
    var displayTitle : String {
        return rawValue.capitalized
    }
}


