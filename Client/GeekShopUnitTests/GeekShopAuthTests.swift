//
//  GeekShopAuthTests.swift
//  GeekShopTests
//
//  Created by Artem Kufaev on 26/04/2019.
//  Copyright © 2019 Artem Kufaev. All rights reserved.
//

import XCTest

@testable import GeekShop

class GeekShopAuthTests: XCTestCase {

    let requestFactory = RequestFactory()
    var auth: AuthRequestFactory! = nil

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        auth = requestFactory.makeAuthRequestFatory()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        auth = nil
    }

    func testLogin() {
        let expectation = XCTestExpectation(description: "Login")
        let data = UserData(id: nil, username: "admin", password: "admin",
                            repeatPassword: nil, email: nil, name: nil, surname: nil, bio: nil, creditCard: nil, gender: nil)
        auth.login(with: data) { response in
            switch response.result {
            case .success: break
            case .failure (let error):
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }

    func testLogout() {
        let expectation = XCTestExpectation(description: "Logout")
        auth.logout(with: 1) { response in
            switch response.result {
            case .success: break
            case .failure (let error):
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }

    func testRegister() {
        let username = randomString(length: 10)
        let password = randomString(length: 20)
        let expectation = XCTestExpectation(description: "Registration")
        let data = UserData(id: nil,
                            username: username,
                            password: password,
                            repeatPassword: nil,
                            email: "some@some.ru",
                            name: "Artem",
                            surname: "Kufaev",
                            bio: "This is good! I think I will switch to another language",
                            creditCard: "9872389-2424-234224-234",
                            gender: "Male")
        auth.register(with: data) { response in
            switch response.result {
            case .success: break
            case .failure (let error):
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }

    func testChangeUserData() {
        let username = randomString(length: 10)
        let password = randomString(length: 20)
        let expectation = XCTestExpectation(description: "Change user data")
        let data = UserData(id: 10, username: username, password: password,
                            repeatPassword: nil,
                            email: "some@some.ru",
                            name: "Artem",
                            surname: "Kufaev",
                            bio: "This is good! I think I will switch to another language",
                            creditCard: "9872389-2424-234224-234",
                            gender: "Male")
        auth.changeUserData(with: data) { response in
            switch response.result {
            case .success: break
            case .failure (let error):
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map { _ in letters.randomElement()! })
    }

}
