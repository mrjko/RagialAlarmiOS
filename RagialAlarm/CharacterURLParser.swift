//
//  CharacterURLParser.swift
//  RagialAlarm
//
//  Created by Jimmy Ko on 2016-06-15.
//  Copyright © 2016 Jimmy Ko. All rights reserved.
//

import Foundation


class CharacterURLParser {
    
    private var characterName: String
    private var serverName: String
    private var characterURL: String
    private var vendingURL: String! = "No shop"
    
    init(name: String, server_name: String){
        self.characterName = name.stringByReplacingOccurrencesOfString(" ", withString: "%20")
        self.serverName = server_name
        self.characterURL = "http://ropd.info/?name=" + self.characterName + "&" + self.serverName
        
        print(self.characterURL)
        
        guard let url = NSURL(string: self.characterURL) else { print("invalid url given"); return}
        
        do {
            let html = try String(contentsOfURL: url)
            if let doc = HTML(html: html, encoding: NSUTF8StringEncoding){
                // this might be a problem? if the name chosen is too ambigous it would take the last found vending url
                
                for link in doc.css("a.ragial"){ self.vendingURL = link["href"] }
            }
        } catch {
            print("could not find a shop open")
        }
    }
    
    func getVendingURL() -> String {
        return self.vendingURL
    }
    
}