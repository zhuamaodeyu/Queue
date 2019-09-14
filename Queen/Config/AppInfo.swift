//
//  AppInfo.swift
//  Queen
//
//  Created by 聂子 on 2019/8/5.
//  Copyright © 2019 聂子. All rights reserved.
//

import Foundation
import LeanCloud
import ObjectMapper


private let userDefault = UserDefaults.standard

struct UserDefaultsKeys {
    static var kSourceLastUpdateDate = "kSourceLastUpdateDate"
    static var kConfigKey = "kConfigKey"
}

class AppInfo {
    static let shared = AppInfo.init()
    private init() {

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

    var config: Config {
        get {
            if let jsonString = userDefault.value(forKey: LCApplication.default.currentUser?.username?.stringValue ?? UserDefaultsKeys.kConfigKey) as? String {
                return (try? Config.init(JSONString: jsonString)) ?? Config.init()
            }
            return Config.init()
        }
        set {
            userDefault.set(config.toJSONString(), forKey: LCApplication.default.currentUser?.username?.stringValue ?? UserDefaultsKeys.kConfigKey)
            userDefault.synchronize()
        }
    }
}
