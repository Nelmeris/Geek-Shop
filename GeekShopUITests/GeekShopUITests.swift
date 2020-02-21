//
//  GeekShopUITests.swift
//  GeekShopUITests
//
//  Created by Artem Kufaev on 19.02.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import XCTest

  
    var app: XCUIApplication!

    override func setUp() {
        self.app = XCUIApplication()
        continueAfterFailure = false
        self.app.launch()
    }

    override func tearDown() {
        
    }

    func testLogin() {
        login()
        
        let alert = app.alerts.firstMatch
        assert(alert.label.contains("Успешно"))
        
        alert.otherElements.buttons.firstMatch.tap()
    }
    
    private func login() {
        app.buttons["Войти"].tap()
        
        let usernameField = app.textFields["Username"]
        usernameField.tap()
        usernameField.typeText("admin")
        
        let passwordField = app.secureTextFields["Password"]
        passwordField.tap()
        passwordField.typeText("admin")
        
        app.tap()
        
        app.buttons["Далее"].tap()
    }
    
    func testLogout() {
        login()
        
        let alert = app.alerts.firstMatch
        assert(alert.label.contains("Успешно"))
        
        alert.otherElements.buttons.firstMatch.tap()
        sleep(1)
        app.tabBars.firstMatch.buttons["Contacts"].tap()
        app.navigationBars.buttons.firstMatch.tap()
        app.navigationBars.buttons["Выйти"].tap()
        
        assert(app.alerts.firstMatch.label.contains("Успешно"))
    }

    func testRegister() {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["Регистрация"].tap()
        
        let usernameField = app.textFields["Username"]
        let passwordField = app.secureTextFields["Password"]
        let repeatPasswordField = app.secureTextFields["Repeat password"]
        
        usernameField.tap()
        usernameField.typeText(randomString(length: 10))
        
        let password = randomString(length: 10)
        passwordField.tap()
        passwordField.typeText(password)
        
        repeatPasswordField.tap()
        repeatPasswordField.typeText(password)
        
        app.staticTexts.firstMatch.tap()
        
        app.buttons["Далее"].tap()
        
        assert(app.alerts.firstMatch.label.contains("успешно"))
    }
    
    func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
}
