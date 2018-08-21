//
//  scrollingAnimationUITests.swift
//  scrollingAnimationUITests
//
//  Created by Nick on 8/20/18.
//  Copyright © 2018 NickOwn. All rights reserved.
//

import XCTest

class scrollingAnimationUITests: XCTestCase {
    let app = XCUIApplication()
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        
        let table = app.tables.element(boundBy:0)
        
        // Get the coordinate for the bottom of the table view
        let tableBottom = table.coordinate(withNormalizedOffset:CGVector(dx: 0.5, dy: 1.0))
        
        // Scroll from tableBottom to new coordinate
        let scrollVector = CGVector(dx: 0.0, dy: -30.0) // Use whatever vector you like
        tableBottom.press(forDuration: 0.5, thenDragTo: tableBottom.withOffset(scrollVector))
        
        
        if app.navigationBars["This is test"].buttons["Compose"].exists {
            app.navigationBars["This is test"].buttons["Compose"].tap()
        }
        
    }
    
    func testTwo(){
        
        let cameraButton = app.navigationBars["scrollingAnimation.firstTableview"].buttons["Camera"]
        cameraButton.tap()
        
        app.navigationBars["scrollingAnimation.SecondView"].buttons["Back"].tap()
       
    }
    
    func testFail() {
        XCTAssert(false, "Test fail")
    }
}
