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
        catalog.getGoods { response in
            switch response.result {
            case .success: break
            case .failure (let error):
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }

}
