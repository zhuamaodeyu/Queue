//
//  LeanCloud+User.swift
//  QueenTests
//
//  Created by 聂子 on 2019/7/26.
//  Copyright © 2019 聂子. All rights reserved.
//

import XCTest
import LeanCloud
@testable import Queen
class LeanCloud_User: XCTestCase {

    override func setUp() {
        UserEntity.register()
    }

    override func tearDown() {
        // 重置方法，在调用每个test用例后调用此方法
    }

    func testExample() {
        let _ = UserEntity.init()

    }

}
