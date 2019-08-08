//
//  WelcomeWorkspaceModel.swift
//  Queen
//
//  Created by 聂子 on 2019/7/14.
//  Copyright © 2019 聂子. All rights reserved.
//

import Foundation
import ObjectMapper

struct WelcomeWorkspaceModel:Mappable {
    init?(map: Map) {
    }

    mutating func mapping(map: Map) {
        address  <-  map["address"]
        projectName    <- map["projectName"]
        update    <- map["update"]
        image  <-  map["image"]
        desc    <- map["desc"]
    }

    var address: String?
    var projectName: String?
    var update: Date?
    var image:String?
    var desc: String?

    init(file url: URL) {
        self.address = url.relativePath
        self.projectName = url.lastPathComponent
        self.update = Date.init()
        self.image = "project"
        self.desc = url.path
    }



}


