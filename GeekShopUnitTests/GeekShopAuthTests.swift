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
        auth.login(userName: "Somebody", password: "mypassword") { response in
            switch response.result {
            case .success: break
            case .failure (let error):
                print(error)
                XCTFail()
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }

    func testLogout() {
        let expectation = XCTestExpectation(description: "Logout")
        auth.logout(userId: 123) { response in
            switch response.result {
            case .success: break
            case .failure (let error):
                print(error)
                XCTFail()
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }

    func testRegister() {
        let expectation = XCTestExpectation(description: "Registration")
        auth.register(userId: 123, userName: "Somebody", password: "mypassword", email: "some@some.ru", gender: "m", creditCard: "9872389-2424-234224-234", bio: "This is good! I think I will switch to another language") { response in
            switch response.result {
            case .success: break
            case .failure (let error):
                print(error)
                XCTFail()
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }

    func testChangeUserData() {
        let expectation = XCTestExpectation(description: "Change user data")
        auth.changeUserData(userId: 123, userName: "Somebody", password: "mypassword", email: "some@some.ru", gender: "m", creditCard: "9872389-2424-234224-234", bio: "This is good! I think I will switch to another language") { response in
            switch response.result {
            case .success: break
            case .failure (let error):
                print(error)
                XCTFail()
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }

}
