//
//  Config.swift
//  Queen
//
//  Created by 聂子 on 2019/7/14.
//  Copyright © 2019 聂子. All rights reserved.
//

import Foundation
import ObjectMapper

let environment:[String: String] = [
    "HOME": NSHomeDirectory(),
    "LANG": "en_GB.UTF-8",
    "TERM": "xterm-256color",
    "LC_CTYPE": "UTF-8",
    "PATH": "\(Path.bundlePath)/bin:\(Path.bundlePath)/libexec/git-core:/usr/bin:/bin:/usr/sbin:/sbin",
    "PYTHONPATH": "\(Path.bundlePath)/lib/python2.7/site-packages",
    "GIT_SSL_CAINFO": "\(Path.bundlePath)/share/roots.pem",
    "GIT_TEMPLATE_DIR": "\(Path.bundlePath)/share/git-core/templates",
    "GIT_EXEC_PATH": "\(Path.bundlePath)/libexec/git-core",
    "SSL_CERT_FILE": "\(Path.bundlePath)/share/roots.pem"
]

struct Config:Mappable {
    struct CIConfig:Mappable {
        var url: String?
        var token: String?
        init?(map: Map) {
        }
        mutating func mapping(map: Map) {
            url    <- map["url"]
            token    <- map["token"]
        }
    }

    var workspaceList:[WelcomeWorkspaceModel] = []
    // CI 配置
    var ciConfig: CIConfig?

    init(){
    }

    init?(map: Map) {
    }

    mutating func mapping(map: Map) {
        ciConfig    <- map["ciConfig"]
        workspaceList    <- map["workspaceList"]
    }
}

