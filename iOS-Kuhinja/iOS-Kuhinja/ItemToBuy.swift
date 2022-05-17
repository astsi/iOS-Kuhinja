//
//  Item.swift
//  iOS-Kuhinja
//
//  Created by Anastasija on 21.4.22..
//

import UIKit
import RealmSwift

public class ItemToBuy: Object {
    
    @objc dynamic var name: String?
    @objc dynamic var amount: Int
    @objc dynamic var date: Date
    var color: UIColor?
    @objc dynamic var priority: Int
    @objc dynamic var isChecked: Bool = false
    
    @objc dynamic var _id = UUID().uuidString

    override public static func primaryKey() -> String? {
        return "_id"
    }
    
    override init() {
        self.amount = 0
        self.priority = 0
        self.date = Date()
        self.name = ""
        self.color = .gray
        super.init()
    }
    
    init(name: String, amount: Int, date: Date, color: UIColor, priority: Int, isChecked: Bool){
        
        self.name = name
        self.amount = amount
        self.date = date
        self.color = color
        self.priority = priority
        self.isChecked = isChecked
        
        super.init()
    }
}


