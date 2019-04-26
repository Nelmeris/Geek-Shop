//
//  GeekShopAuthTests.swift
//  GeekShopTests
//
//  Created by Артем Куфаев on 26/04/2019.
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
        //        auth.register(userId: 123, userName: "Somebody", password: "mypassword", email: "some@some.ru", gender: "m", creditCard: "9872389-2424-234224-234", bio: "This is good! I think I will switch to another language") { response in
        //            switch response.result {
        //            case .success(let result):
        //                print(result)
        //            case .failure(let error):
        //                print(error.localizedDescription)
        //            }
        //        }
        //        auth.logout(userId: 123) { response in
        //            switch response.result {
        //            case .success(let result):
        //                print(result)
        //            case .failure(let error):
        //                print(error.localizedDescription)
        //            }
        //        }
        //        auth.changeUserData(userId: 123, userName: "Somebody", password: "mypassword", email: "some@some.ru", gender: "m", creditCard: "9872389-2424-234224-234", bio: "This is good! I think I will switch to another language") { response in
        //            switch response.result {
        //            case .success(let result):
        //                print(result)
        //            case .failure(let error):
        //                print(error.localizedDescription)
        //            }
        //        }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        auth = nil
    }
    
    func testLogin() {
        let expectation = XCTestExpectation(description: "Logining")
        auth.login(userName: "Somebody", password: "mypassword") { response in
            switch response.result {
            case .success(_): break
            case .failure(_):
                XCTFail()
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testLogout() {
        let expectation = XCTestExpectation(description: "Logining")
        auth.logout(userId: 123) { response in
            switch response.result {
            case .success(_): break
            case .failure(_):
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
            case .success(_): break
            case .failure(_):
                XCTFail()
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testChangeUserData() {
        let expectation = XCTestExpectation(description: "Changing user data")
        auth.changeUserData(userId: 123, userName: "Somebody", password: "mypassword", email: "some@some.ru", gender: "m", creditCard: "9872389-2424-234224-234", bio: "This is good! I think I will switch to another language") { response in
            switch response.result {
            case .success(_): break
            case .failure(_):
                XCTFail()
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
}
