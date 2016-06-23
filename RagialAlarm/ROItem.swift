//
//  ROItem.swift
//  RagialAlarm
//
//  Created by Jimmy Ko on 2016-06-15.
//  Copyright © 2016 Jimmy Ko. All rights reserved.
//

import Foundation

class ROItem {
    
    private var name: String
    private var price: String
    private var quantity: String
    
    init(n: String, p: String, q: String){
        self.name = n
        self.price = p
        self.quantity = q
    }
    
    func getName() -> String {
        return self.name
    }
    
    func getPrice() -> String {
        return self.price
    }
    
    func getQuantity() -> String {
        return self.quantity
    }

}