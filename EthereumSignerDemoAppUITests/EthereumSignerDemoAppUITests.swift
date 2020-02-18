//
//  EthereumSignerDemoAppUITests.swift
//  EthereumSignerDemoAppUITests
//
//  Created by Apple Imac on 14/02/20.
//  Copyright © 2020 Self. All rights reserved.
//

import XCTest

class EthereumSignerDemoAppUITests: XCTestCase {
    let app = XCUIApplication()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
   
    private func setupScreenSuccessCase() {
          let privateKeyTextField = app.textFields["setupVC.privatekey.textfield"]
          if privateKeyTextField.exists {
                privateKeyTextField.tap()
                privateKeyTextField.buttons["Clear text"].tap()
                privateKeyTextField.typeText("A84CD98995E775664981AA337646FF3BA7C1B3C29F41A845CED7A15173CA39A7")
                app.buttons["Setup.Done.Button"].tap()
            }
    }
    
    private func accountScreenSuccessCaseToSignInScreen() {
        setupScreenSuccessCase()
        app.buttons["Account.SignButton"].tap()
    }
    
    private func accountScreenSuccessCaseToValidateScreen() {
        setupScreenSuccessCase()
        app.buttons["Account.ValidateButton"].tap()
    }
    
    func testSetupVC() {
        let privateKeyTextField = app.textFields["setupVC.privatekey.textfield"]
        if privateKeyTextField.exists { //Check setup screen passed
            privateKeyTextField.tap() //A84CD98995E775664981AA337646FF3BA7C1B3C29F41A845CED7A15173CA39A7
            guard let keyText = privateKeyTextField.value as? String else {
                XCTFail("Private key is not string type")
                return
            }
            if keyText.count > 0 {
                  privateKeyTextField.buttons["Clear text"].tap()
               }
             app.buttons["Setup.Done.Button"].tap()
             XCTAssertEqual(app.alerts.element.label, "Private Key Error")
             app.alerts.buttons["Ok"].tap()
             privateKeyTextField.tap()
             privateKeyTextField.typeText("A84CD98995E775664981AA337646FF3BA7C1B3C29F41A845CED7A15173CA39A7")
            app.buttons["Setup.Done.Button"].tap()
            Thread.sleep(forTimeInterval: 2.0)
        }
    }
    
    func testAccountScreen()  {
         setupScreenSuccessCase()
        XCTAssertTrue(app.staticTexts["Account.AccountAddress"].exists, "Account address field doesn't exist")
      //  XCTAssertTrue(app.staticTexts["Account.Balance"].exists, "Account balance field doesn't exist")
        XCTAssertTrue(app.buttons["Account.SignButton"].exists, "SignIn button doesn't exts")
        XCTAssertTrue(app.buttons["Account.ValidateButton"].exists, "Validate button doesn't exts")

        Thread.sleep(forTimeInterval: 2.0)
    }
    
    func testSignScreen()  {
        accountScreenSuccessCaseToSignInScreen()
        let signingMessageTextfield = app.textFields["SignIn.message.textfield"]
        XCTAssertTrue(signingMessageTextfield.exists, "Message text field should present")
        XCTAssertTrue(app.buttons["SignIn.Done.Button"].exists, "SignIn message button doesn't exts")
        
        app.buttons["SignIn.Done.Button"].tap()
        
        XCTAssertEqual(app.alerts.element.label, "Message Error")
        app.alerts.buttons["Ok"].tap()
        
        signingMessageTextfield.tap()
        signingMessageTextfield.typeText("This is mocking test")

        app.buttons["SignIn.Done.Button"].tap()
        Thread.sleep(forTimeInterval: 2.0)
    }
    
    func testValidateScreen()  {
        accountScreenSuccessCaseToValidateScreen()
        let validateMessageTextfield = app.textFields["Validate.message.textfield"]
        XCTAssertTrue(validateMessageTextfield.exists, "Message text field should present")
        XCTAssertTrue(app.buttons["Validate.Done.Button"].exists, "Validate message button doesn't exts")
        
        guard let messageText = validateMessageTextfield.value as? String else {
            XCTFail("Message is not string type")
            return
        }
        
        if messageText.count > 0 {
            validateMessageTextfield.buttons["Clear text"].tap()
            app.buttons["Validate.Done.Button"].tap()
            XCTAssertEqual(app.alerts.element.label, "Validate Error")
            app.alerts.buttons["Ok"].tap()
            validateMessageTextfield.tap()
            validateMessageTextfield.typeText("This is mocking test")
        }
        app.buttons["Validate.Done.Button"].tap()
        Thread.sleep(forTimeInterval: 2.0)

    }
}
