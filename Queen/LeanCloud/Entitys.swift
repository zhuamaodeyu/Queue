//
//  Entitys.swift
//  Queen
//
//  Created by 聂子 on 2019/7/26.
//  Copyright © 2019 聂子. All rights reserved.
//

import Foundation
import LeanCloud
//let number       : LCNumber       = 42
//let bool         : LCBool         = true
//let string       : LCString       = "foo"
//let dictionary   : LCDictionary   = LCDictionary(["name": string, "count": number])
//let array        : LCArray        = LCArray([number, bool, string])
//let data         : LCData         = LCData()
//let date         : LCDate         = LCDate()
//let null         : LCNull         = LCNull()
//let geoPoint     : LCGeoPoint     = LCGeoPoint(latitude: 45, longitude: -45)
//let acl          : LCACL          = LCACL()
//let object       : LCObject       = LCObject()
//let relation     : LCRelation     = object.relationForKey("elements")
//let user         : LCUser         = LCUser()
//let file         : LCFile         = LCFile()
//let installation : LCInstallation = LCInstallation()

class UserEntity: LCUser {
    /**
     1. master 管理者  每个公司只有一个
     */
    @objc dynamic var master: LCBool = false
}

// 专门用于用户查询的
class UserFindEntity: LCObject {
    @objc dynamic var username: LCString?
    @objc dynamic var email: LCString?
    @objc dynamic var mobilePhoneNumber: LCString?
    @objc dynamic var master: LCBool = false

    override static func objectClassName() -> String {
        return "User_Find"
    }
}

class UserClientASssociation: LCObject {
    /**
     1. 用户ID
     2. 客户端md5
     3.
     */
    @objc dynamic var user_id: LCString?
    @objc dynamic var client_id: LCString?

    override static func objectClassName() -> String {
        return "User_Client_Association"
    }


}

// 项目组
class TeamEntity:LCObject {
    /**
     1. 项目组名称
     2. 项目组负责任ID
     3. 项目组简介描述
     4. 项目组管理员id 组
     5. 项目成员ids
     */
    @objc dynamic var name: LCString = ""
    @objc dynamic var manager_Id: LCString = ""
    @objc dynamic var desc: LCString = ""
    @objc dynamic var admin_ids:LCArray = []
    @objc dynamic var member_ids:LCArray = []

    override static func objectClassName() -> String {
        return "Team_Entity"
    }
}

// spec 源
class SpecSourceEntity: LCObject {
    /**
     1. 名字
     2. 地址
     3. 项目组ID
     4. 是否是 master
     5. 是否是默认的
     6. 是否是二进制版
     7. 是否是私有的
     */
    @objc dynamic var name: LCString?
    @objc dynamic var host: LCString?
    @objc dynamic var teamId: LCString?
    @objc dynamic var master: LCBool = false
    @objc dynamic var `default`: LCBool = false
    @objc dynamic var binrary: LCBool = false
    @objc dynamic var `public`: LCBool = false

    override static func objectClassName() -> String {
        return "Spec_Source_Entity"
    }
}


class PodDescriptionEntity: LCObject {

    /**
     1. 名称
     2. 负责人ID
     3. 项目组ID

    */
    @objc dynamic var name: LCString?
    @objc dynamic var master_Id: LCString?
    @objc dynamic var team_Id: LCString?




    override static func objectClassName() -> String {
        return "Pod_Description"
    }
}

// CI 源
class CISourcesEntity: LCObject {
    @objc dynamic var name: LCString?
    @objc dynamic var host: LCString?
    @objc dynamic var team_id: LCString?


    override static func objectClassName() -> String {
        return "CI_Sources_Manager"
    }
}

