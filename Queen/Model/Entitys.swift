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
     1. 管理员 每个项目组都会有多个
     2. master 管理者  每个公司只有一个
     3. 项目组ID

     */
    @objc dynamic var admin: LCBool = false
    @objc dynamic var master: LCBool = false
    @objc dynamic var teamId: LCString?
}
// 专门用于用户查询的
class UserFindEntity: LCObject {
    @objc dynamic var username: LCString?
    @objc dynamic var email: LCString?
    @objc dynamic var mobilePhoneNumber: LCString?
    @objc dynamic var admin: LCBool = false
    @objc dynamic var master: LCBool = false
    @objc dynamic var teamId: LCString?

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
    @objc dynamic var user_ID: LCString?
    @objc dynamic var client_ID: LCString?

    override static func objectClassName() -> String {
        return "User_Client_Association"
    }
}

// 项目组
class ProjectTeamEntity:LCObject {
    /**
     1. 项目组名称
     2. 项目组负责任ID
     3. 项目组简介描述
     */
    @objc dynamic var name: LCString?
    @objc dynamic var managerId: LCString?
    @objc dynamic var desc: LCString?

    override static func objectClassName() -> String {
        return "Project_Team"
    }
}


class PodSpecEntity: LCObject {
    /**
     1. 名字
     2. 地址
     3. 项目组ID
     4. 是否是master
     5. 是否是默认的
     6. 是否是二进制版
     7. 是否是源码版
     8. 是否是私有的
     */
    @objc dynamic var name: LCString?
    @objc dynamic var address: LCString?
    @objc dynamic var teamId: LCString?
    @objc dynamic var master: LCBool = false
    @objc dynamic var `default`: LCBool = false
    @objc dynamic var binrary: LCBool = false
    @objc dynamic var source: LCBool = false
    @objc dynamic var `private`: LCBool = false

    override static func objectClassName() -> String {
        return "Pod_Manager"
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
