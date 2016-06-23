//
//  VendURLParser.swift
//  RagialAlarm
//
//  Created by Jimmy Ko on 2016-06-16.
//  Copyright © 2016 Jimmy Ko. All rights reserved.
//

import Foundation

class VendURLParser {
    
    private var vendItems = ROItems()
    
    init(u: String){
        
        guard let url = NSURL(string: u) else { print("invalid url"); return }
        
        do {
            let html = try String(contentsOfURL: url)
            if let doc = HTML(html: html, encoding: NSUTF8StringEncoding){
                for i in 0.stride(to: doc.css("td.name, td.price, td.amt").count, by: 3){
                    let name = doc.css("td.name, td.price, td.amt")[i].text
                    let quantity = doc.css("td.name, td.price, td.amt")[i+1].text
                    let price = doc.css("td.name, td.price, td.amt")[i+2].text
                    let item = ROItem(n:name!, p:price!, q:quantity!)
                    self.vendItems.addItem(item)
                }
            }
            
        } catch {
            print("could not find a shop open")
        }
        
        
    }
    
    
    func getVendingItems() -> ROItems {
        return self.vendItems
    }
 
    
}