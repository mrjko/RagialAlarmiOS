//
//  ROItems.swift
//  RagialAlarm
//
//  Created by Jimmy Ko on 2016-06-15.
//  Copyright © 2016 Jimmy Ko. All rights reserved.
//

import Foundation

class ROItems {
    
    private var items = [ROItem]()
    
    init(){ }
    
    func getItems() -> [ROItem] {
        return self.items
    }
    
    func addItem(item: ROItem){
        self.items.append(item)
    }
    
    func removeItemByName(name: String){
        self.items = items.filter({ $0.getName() != name })
    }
    
    func getTotalQuantity() -> Int{
        var totalQty = 0
        for i in 0.stride(to: getItems().count, by: 1) {
            totalQty += convertQuantityToInteger(getItems()[i].getQuantity())
        }
        return totalQty
    }
    
    func convertQuantityToInteger(quantity: String) -> Int {
        var characters = Array(quantity.characters)
        characters = characters.filter({$0 != "x"})
        let string = String(characters)
        return Int(string)!
    }
}