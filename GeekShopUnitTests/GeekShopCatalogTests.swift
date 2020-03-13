//
//  GeekShopCatalogTests.swift
//  GeekShopUnitTests
//
//  Created by Artem Kufaev on 26/04/2019.
//  Copyright © 2019 Artem Kufaev. All rights reserved.
//

import XCTest

@testable import GeekShop

class GeekShopCatalogTests: XCTestCase {

    let requestFactory = RequestFactory()
    var catalog: ShopRequestFactory! = nil

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        catalog = requestFactory.makeShopRequestFactory()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        catalog = nil
    }

    func testGetCatalogData() {
        let expectation = XCTestExpectation(description: "Get catalog data")
        catalog.getCatalog(pageNumber: 123, categoryId: 1) { response in
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

    func testGetGoodById() {
        let expectation = XCTestExpectation(description: "Get good by id")
        catalog.getGood(by: 123) { response in
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
