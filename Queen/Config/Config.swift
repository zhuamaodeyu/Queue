//
//  Config.swift
//  Queen
//
//  Created by 聂子 on 2019/7/14.
//  Copyright © 2019 聂子. All rights reserved.
//

import Foundation

private let userDefault = UserDefaults.standard


struct DocumentAssociatedKeys {
    static var qworkspace = "qworkspace"
    static var yaml = "yaml"
    static var config = "config"
    static var mapping = "mapping"
}

struct DocumentationAssociatedKey {
    static var url = "url"
    static var name = "name"
}




class Config {
    private struct AssociatedKeys {
        static var kOpenWorkspaceList = "kOpenWorkspaceList"
    }
    static let shared = Config.init()
    private init() {

    }
    var workspaceList:[WelcomeWorkspaceModel] = []
}
