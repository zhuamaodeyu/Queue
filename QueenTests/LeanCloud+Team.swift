//
//  LeanCloud+Team.swift
//  QueenTests
//
//  Created by 聂子 on 2019/8/3.
//  Copyright © 2019 聂子. All rights reserved.
//

import XCTest
import LeanCloud
@testable import Queen

class LeanCloud_Team: XCTestCase {

    override func setUp() {
//        let _ = LCUser.logIn(email: "playtomandjerry@gmail.com", password: "Xiaohundan3575") { result in
//            switch result {
//            case .success(let object):
//                print("object_id\(object.objectId)")
//                break
//            case .failure(let error):
//                break
//            }
//        }
    }

    func test_create() {
        let userID = LCString.init("5d45a08110004d00084f56f3")
//        guard let userID =  LCApplication.default.currentUser?.objectId else {
//            return
//        }
        let team = TeamEntity.init()
        team.desc = LCString.init("测试项目组")
        team.name = LCString.init("测试")
        team.manager_Id = userID
        team.admin_ids = LCArray.init([userID])
        team.member_ids = LCArray.init([userID])
        _ = team.save()
    }

    func testf_find() {
        let userID = LCString.init("5d45a08110004d00084f56f3")
        let query = LCQuery.init(className: TeamEntity.objectClassName())
        query.whereKey("member_ids", .containedIn([userID]))
        let result = query.find()
        if result.isSuccess, let objects = result.objects as? [TeamEntity] {
            debugPrint("\(String(describing: objects.first?.admin_ids.value))")
        }

    }

}
