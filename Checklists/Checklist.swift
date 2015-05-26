//
//  Checklist.swift
//  Checklists
//
//  Created by Graeme Kelly on 20/05/2015.
//  Copyright (c) 2015 Graeme Kelly. All rights reserved.
//

import UIKit

class Checklist: NSObject, NSCoding {

    var name = ""
    var iconName: String
    var items = [ChecklistItem]()

    
    init(name: String) {
        self.name = name
        self.iconName = "No Icon"
        super.init()
    }
    
    init(name: String, iconName: String) {
        self.name = name
        self.iconName = iconName
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObjectForKey("Name") as! String
        items = aDecoder.decodeObjectForKey("Items") as! [ChecklistItem]
        iconName = aDecoder.decodeObjectForKey("IconName") as! String

        
        super.init()
    }
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: "Name")
        aCoder.encodeObject(items, forKey: "Items")
        aCoder.encodeObject(iconName, forKey: "IconName")

    }
   
   
    func countUncheckedItems() -> Int {
        var count = 0
        for item in items {
            if !item.checked {
                count += 1
            }
        }
        return count
    }
}
