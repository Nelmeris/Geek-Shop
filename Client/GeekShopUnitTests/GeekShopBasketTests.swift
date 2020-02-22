//
//  GeekShopBasketTests.swift
//  GeekShopUnitTests
//
//  Created by Artem Kufaev on 14/05/2019.
//  Copyright © 2019 Artem Kufaev. All rights reserved.
//

import XCTest

@testable import GeekShop

class GeekShopBasketTests: XCTestCase {
    
    let requestFactory = RequestFactory()
    var basket: BasketRequestFactory! = nil
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        basket = requestFactory.makeBasketRequestFactory()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        basket = nil
    }
    
    func testGetBasket() {
        let expectation = XCTestExpectation(description: "Get basket")
        basket.get(userId: 8) { response in
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
    
    func testAddToBasket() {
        let expectation = XCTestExpectation(description: "Add to basket")
        basket.add(productId: 1, userId: 8, quantity: 1) { response in
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
    
    func testRemoveFromBasket() {
        let expectation = XCTestExpectation(description: "Remove from basket")
        basket.remove(productId: 1, userId: 8) { response in
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
