//
//  RagialAlarmTests.swift
//  RagialAlarmTests
//
//  Created by Jimmy Ko on 2016-06-10.
//  Copyright © 2016 Jimmy Ko. All rights reserved.
//

import XCTest
@testable import RagialAlarm

class RagialAlarmTests: XCTestCase {
    
    var vc: ViewController!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        vc = storyboard.instantiateInitialViewController() as! ViewController
        let _ = vc.view

    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
    
    // Note: After actually getting the app to parse items need to revisit these the ones with !!!
    
    
    // !!!
    func testRetrieveItems() {
        
        XCTAssert(true);
        
        // checking when no input
        
        XCTAssert(vc.vendItems.getItems().count == 0)
        
        // testing when name for characterNameField is not the right format
        
        vc.characterName = "12"
        vc.retrieveItems(vc.retrieveItemBtn);
        XCTAssert(vc.vendItems.getItems().count == 0)
        
        // bvt test
        
        vc.characterName = "123"
        vc.retrieveItems(vc.retrieveItemBtn)
        XCTAssert(vc.vendItems.getItems().count == 0)
        
        vc.characterName = "1234"
        vc.retrieveItems(vc.retrieveItemBtn)
        XCTAssert(vc.vendItems.getItems().count == 0)
        
        // testing when name for characterNameField is in the right format
        
        vc.characterName = "apples"
        vc.retrieveItems(vc.retrieveItemBtn)
        XCTAssert(vc.vendItems.getItems().count == 0)
        
        vc.characterName = "/[]`~-.,+-|"
        vc.retrieveItems(vc.retrieveItemBtn)
        
        vc.vendItems.addItem(ROItem(n:"test", p:"123", q:"x1"))
        vc.vendItems.addItem(ROItem(n:"test", p:"123", q:"x1"))

        XCTAssert(vc.vendItems.getItems().count == 2)
        
    }
    
    
    
    // !!!
    func testSetAlarm(){
        
        // by default should be false
        vc.setAlarm(vc.setAlarmBtn)
        XCTAssertFalse(vc.isAlarmSet)
        
        vc.vendItems.addItem(ROItem(n:"test", p:"123", q:"x1"))
        
        // setting the alarm
        vc.setAlarm(vc.setAlarmBtn)
        XCTAssert(vc.isAlarmSet)
            
        // cancelling the alarm
        vc.setAlarm(vc.setAlarmBtn)
        XCTAssertFalse(vc.isAlarmSet)
        
    }
    
    func testCharacterURLParser() {
        
        // need to come up with a way to consistently test vending shops
        
    }
    
    func testRemoveItemsByName(){
        vc.vendItems.addItem(ROItem(n:"test", p:"123", q:"x1"))
        XCTAssert(vc.vendItems.getItems().count == 1)
        vc.vendItems.removeItemByName("test")
        XCTAssert(vc.vendItems.getItems().count == 0)
    }
    
    func testNotifyUser(){
        vc.vendItems.addItem(ROItem(n:"test", p:"123", q:"x1"))
        vc.setAlarm(vc.setAlarmBtn)
        vc.vendItems.removeItemByName("test")
    }
    
    
    
}
