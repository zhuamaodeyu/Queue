//
//  LeanCloud+SpecSources.swift
//  QueenTests
//
//  Created by 聂子 on 2019/8/3.
//  Copyright © 2019 聂子. All rights reserved.
//

import XCTest
import LeanCloud
@testable import Queen

class LeanCloud_SpecSources: XCTestCase {

    func test_create() {

    }
//    @objc dynamic var name: LCString?
//    @objc dynamic var address: LCString?
//    @objc dynamic var teamId: LCString?
//    @objc dynamic var master: LCBool = false
//    @objc dynamic var `default`: LCBool = false
//    @objc dynamic var binrary: LCBool = false
//    @objc dynamic var source: LCBool = false
//    @objc dynamic var `private`: LCBool = false
    
    func test_create_default() {
        let master = SpecSourceEntity.init()
        master.host = LCString.init("https://github.com/CocoaPods/Specs.git")
        master.name = LCString.init("master")
        master.teamId = nil
        master.master = LCBool.init(true)
        master.default = LCBool.init(true)
        master.binrary = LCBool.init(false)
        master.public = LCBool.init(true)
        assert(master.save().isSuccess)
    }

    func test_create_open() {
        let open_bin = SpecSourceEntity.init()
        open_bin.host = LCString.init("https://github.com/zhuamaodeyu/LibSpec.git")
        open_bin.name = LCString.init("LibSpec")
        // 说明公开
        open_bin.teamId = nil
        open_bin.master = LCBool.init(false)
        open_bin.default = LCBool.init(true)
        open_bin.binrary = LCBool.init(true)
        open_bin.public = LCBool.init(true)
        assert(open_bin.save().isSuccess)

        let open_soc = SpecSourceEntity.init()
        open_soc.host = LCString.init("git@gitee.com:wenliaokeji/Spec.git")
        open_soc.name = LCString.init("Spec")
        // 说明公开
        open_soc.teamId = nil
        open_soc.master = LCBool.init(false)
        open_soc.default = LCBool.init(true)
        open_soc.binrary = LCBool.init(false)
        open_soc.public = LCBool.init(true)
        assert(open_soc.save().isSuccess)
    }

    func test_create_private() {
        let open_bin = SpecSourceEntity.init()
        open_bin.host = LCString.init("https://gitee.com/wenliaokeji/Spec.git")
        open_bin.name = LCString.init("PrivateSpec")
        // 说明公开
        open_bin.teamId = nil
        open_bin.master = LCBool.init(false)
        open_bin.default = LCBool.init(false)
        open_bin.binrary = LCBool.init(false)
        open_bin.public = LCBool.init(false)
        assert(open_bin.save().isSuccess)
    }




    func test_find() {
        var teams = Set<String>.init()

        let query = LCQuery.init(className: SpecSourceEntity.objectClassName())
        query.whereKey("team", .containedIn(Array(teams)))
        query.whereKey("team", .notExisted)
        query.whereKey("public", .equalTo(LCBool.init(true)))
        let result = query.find()
        if result.isSuccess , let objects = result.objects as? [SpecSourceEntity] {
            debugPrint("")
        }
    }

}
