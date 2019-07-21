//
//  Config.swift
//  Queen
//
//  Created by 聂子 on 2019/7/14.
//  Copyright © 2019 聂子. All rights reserved.
//

import Foundation

private let userDefault = UserDefaults.standard

struct UserDefaultsKeys {
    struct WelcomeWindowKeys {
        static var kOpenWorkspaceList = "kOpenWorkspaceList"
    }
}

class Config {
    static let shared = Config.init()
    private init() {

    }
    var workspaceList:[WelcomeWorkspaceModel] {
        get {
            if let data = userDefault.value(forKey: UserDefaultsKeys.WelcomeWindowKeys.kOpenWorkspaceList) as? Data {
                if let repo = try? JSONDecoder().decode([WelcomeWorkspaceModel].self, from: data) {
                    return repo
                }
            }
            return []
        }
        set {
            if let data = try? JSONEncoder.init().encode(newValue) {
                userDefault.set(data, forKey: UserDefaultsKeys.WelcomeWindowKeys.kOpenWorkspaceList)
            }
        }
    }
}
