//
//  ViewController.swift
//  RagialAlarm
//
//  Created by Jimmy Ko on 2016-06-10.
//  Copyright © 2016 Jimmy Ko. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Properties
    
    @IBOutlet weak var characterNameField: UITextField!
    @IBOutlet var serverLabel: UILabel!
    @IBOutlet var retrieveItemBtn: UIButton!
    @IBOutlet weak var serverSwitchBtn: UISwitch!
    @IBOutlet var setAlarmBtn: UIButton!
    @IBOutlet weak var vendingItemsLabel: UILabel!
    @IBOutlet weak var vendItemTableView: UITableView!
    
    var characterName: String! = ""
    var isAlarmSet: Bool = false
    var serverName: String! = "s=7"
    var alarmedItems = ROItems()
    var vendItems = ROItems()
    var timer = NSTimer()
    
    
    // MARK: UITextFieldDelegate
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
 
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        characterName = textField.text! + string
        return true;
    }
 
    // MARK: UITextViewDelegate 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        characterNameField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vendItems.getItems().count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // MARK: UITableViewDataSource
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Vend Item Cell", forIndexPath: indexPath) as UITableViewCell
        let vendItem = vendItems.getItems()[indexPath.row]
        cell.textLabel?.text = vendItem.getName()
        cell.detailTextLabel?.text = vendItem.getPrice()
        return cell;
    }
    
    // MARK: Action
    
    @IBAction func retrieveItems(sender: UIButton) {
        if (checkValidName()){
            let parseChar = CharacterURLParser(name: characterName, server_name: serverName)
            let parseItems = VendURLParser(u: parseChar.getVendingURL())
            vendItems = parseItems.getVendingItems()
            /*
            for i in 0.stride(to: vendItems.getItems().count, by: 1) {
                print(vendItems.getItems()[i].getQuantity())
            }
             */
            self.vendItemTableView.reloadData()
        }
    }
    
    @IBAction func setAlarm(sender: UIButton) {
        if (isItemRetrieved()){
            if (isAlarmSet){
                stopTimer()
            } else {
                startTimer()
            }
        }
    }
    
    @IBAction func serverSwitch(sender: UISwitch) {
        if (serverSwitchBtn.on){
            serverName = "s=7"
            serverLabel.text = "Renewal"
        } else {
            serverName = "s=6"
            serverLabel.text = "Classic"
        }
    }

    // MARK: Additional Functions
    
    func isItemRetrieved() -> Bool{
        if (self.vendItems.getItems().count == 0){
            return false
        } else {
            return true
        }
    }
    
    func checkValidName() -> Bool{
        if (characterName.characters.count <= 3){
            return false;
        } else {
            return true;
        }
    }
    
    func startTimer(){
        alarmedItems = vendItems
        timer = NSTimer.scheduledTimerWithTimeInterval(180, target: self, selector: #selector(updateVendItems), userInfo: nil, repeats: true)
        isAlarmSet = true
        setAlarmBtn.setTitle("Alarm is set", forState: UIControlState.Normal)
    }
    
    func stopTimer(){
        timer.invalidate()
        isAlarmSet = false
        setAlarmBtn.setTitle("Set Alarm", forState: UIControlState.Normal)
    }
    
    func updateVendItems(){
        let parseChar = CharacterURLParser(name: characterName, server_name: serverName)
        let parseItems = VendURLParser(u: parseChar.getVendingURL())
        vendItems = parseItems.getVendingItems()
        if (alarmedItems.getTotalQuantity() != vendItems.getTotalQuantity()){
            print("NOTIFY THE USER THAT SOMETHING HAS BEEN SOLD!")
        } else {
            print("NOTHING HAS BEEN SOLD")
        }
    }

}

