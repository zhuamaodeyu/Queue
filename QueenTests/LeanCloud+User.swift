//
//  LeanCloud+User.swift
//  QueenTests
//
//  Created by 聂子 on 2019/7/26.
//  Copyright © 2019 聂子. All rights reserved.
//

import XCTest
//import LeanCloud
@testable import Queue
class LeanCloud_User: XCTestCase {

    override func setUp() {
        UserEntity.register()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
