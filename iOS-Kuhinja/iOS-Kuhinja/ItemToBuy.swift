//
//  Item.swift
//  iOS-Kuhinja
//
//  Created by Anastasija on 21.4.22..
//

import UIKit


public class ItemToBuy {
    
    var uuid: UUID
    var name: String
    var amount: Int
    var date: Date
    var color: UIColor
    var priority: Int
    var isChecked: Bool = false
    
    init(uuid: UUID, name: String, amount: Int, date: Date, color: UIColor, priority: Int, isChecked: Bool){
        self.uuid = uuid
        self.name = name
        self.amount = amount
        self.date = date
        self.color = color
        self.priority = priority
        self.isChecked = isChecked
    }
}

//public enum Priority : String {
//    case low, medium, high
//
//    var displayTitle : String {
//        return rawValue.capitalized
//    }
//
//    var displayIndex : Int {
//
//        switch self {
//        case .low:
//            return 0
//        case .medium:
//            return 1
//        case .high:
//            return 2
//        }
//    }
//}


