//
//  WelcomeWorkspaceModel.swift
//  Queen
//
//  Created by 聂子 on 2019/7/14.
//  Copyright © 2019 聂子. All rights reserved.
//

import Foundation
import Yaml

struct WelcomeWorkspaceModel:Codable {
    var address: URL
    var projectName: String
    var update: Date
    var image:String
    var desc: String

    init(file url: URL) {
        self.address = url
        self.projectName = ""
        self.update = Date.init()
        self.image = ""
        self.desc = ""
    }
}


