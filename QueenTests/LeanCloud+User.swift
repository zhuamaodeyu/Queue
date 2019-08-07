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

    func test_regster() {
        let user = UserEntity.init()
        user.username = LCString.init("zhangsan")
        user.email = LCString.init("playtomandjerry@gmail.com")
        user.password = LCString.init("Xiaohundan3575")
        user.admin = LCBool.init(true)
        user.master = LCBool.init(true)
        user.mobilePhoneNumber = LCString.init("13265549803")
        assert(user.save().isSuccess)
    }

    func test_login() {
        let _ = LCUser.logIn(email: "playtomandjerry@gmail.com", password: "Xiaohundan3575") { result in
            switch result {
            case .success(let object):
                print("object_id\(String(describing: object.objectId))")
                break
            case .failure(let _):
                break
            }
        }
    }

}
