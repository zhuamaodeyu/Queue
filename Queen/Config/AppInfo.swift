//
//  AppInfo.swift
//  Queen
//
//  Created by 聂子 on 2019/8/5.
//  Copyright © 2019 聂子. All rights reserved.
//

import Foundation
import LeanCloud


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



private let userDefault = UserDefaults.standard

struct UserDefaultsKeys {
    struct WelcomeWindowKeys {
        static var kOpenWorkspaceList = "kOpenWorkspaceList"
    }

    static var kSourceLastUpdateDate = "kSourceLastUpdateDate"
}

class AppInfo {
    static let shared = AppInfo.init()
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
                userDefault.synchronize()
            }
        }
    }

    var sourceLastUpdateDate: Date? {
        get {
            if let dateString = userDefault.value(forKey: UserDefaultsKeys.kSourceLastUpdateDate) as? String {
                let datef = DateFormatter.init(withFormat: "yyyy-MM-dd", locale: "en_US_POSIX")
                return datef.date(from: dateString)
            }
            return nil
        }
        set {
            let datef = DateFormatter.init(withFormat: "yyyy-MM-dd", locale: "en_US_POSIX")
            userDefault.set(datef.string(from: sourceLastUpdateDate ?? Date.init()), forKey: UserDefaultsKeys.kSourceLastUpdateDate)
            userDefault.synchronize()
        }
    }

}
