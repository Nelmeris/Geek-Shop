//
//  SnapshotGeekShopUITests.swift
//  SnapshotGeekShopUITests
//
//  Created by Artem Kufaev on 21.02.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import XCTest

class SnapshotGeekShopUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        
        setupSnapshot(app)
        
        app.launch()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() {
        // Авторизация
        snapshot("AuthScreen")
        
        // Регистрация
        app.buttons["Регистрация"].tap()
        snapshot("RegisterScreen")
        
        // Обратно
        app.navigationBars.buttons.firstMatch.tap()
        
        // Логин
        app.buttons["Войти"].tap()
        snapshot("LoginScreen")
        
        // Ввод данных
        let usernameField = app.textFields["Username"]
        usernameField.tap()
        usernameField.typeText("admin")
        
        let passwordField = app.secureTextFields["Password"]
        passwordField.tap()
        passwordField.typeText("admin")
        
        // Нажатие на "далее"
        app.tap()
        app.buttons["Далее"].tap()
        let alert = app.alerts.firstMatch
        alert.otherElements.buttons.firstMatch.tap()
        sleep(1)
        
        // Каталог
        snapshot("CatalogScreen")
        
        // Корзина
        app.tabBars.firstMatch.buttons["Downloads"].tap()
        snapshot("CatalogScreen")
        
        // Профиль
        app.tabBars.firstMatch.buttons["Contacts"].tap()
        snapshot("ProfileScreen")
        
        // Редактирование
        app.navigationBars.buttons.firstMatch.tap()
        snapshot("EditProfileScreen")
        app.navigationBars.buttons.firstMatch.tap()
    }

}
