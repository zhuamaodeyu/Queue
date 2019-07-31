//
//  Config.swift
//  Queen
//
//  Created by 聂子 on 2019/7/14.
//  Copyright © 2019 聂子. All rights reserved.
//

import Foundation
import LeanCloud

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

extension Config {
    func getHardwareUUID() -> String? {
        let dev = IOServiceMatching("IOPlatformExpertDevice")
        let platformExpert: io_service_t = IOServiceGetMatchingService(kIOMasterPortDefault, dev)
        let serialNumberAsCFString = IORegistryEntryCreateCFProperty(platformExpert, kIOPlatformUUIDKey as CFString, kCFAllocatorDefault, 0)
        IOObjectRelease(platformExpert)
        let ser: CFTypeRef? = serialNumberAsCFString?.takeUnretainedValue()
        if let result = ser as? String {
            return result
        }
        return nil
    }

    func getHardwareSerialNumber() -> String? {
        let dev = IOServiceMatching("IOPlatformExpertDevice")
        let platformExpert: io_service_t = IOServiceGetMatchingService(kIOMasterPortDefault, dev)
        let serialNumberAsCFString = IORegistryEntryCreateCFProperty(platformExpert, kIOPlatformSerialNumberKey as CFString, kCFAllocatorDefault, 0)
        IOObjectRelease(platformExpert)
        let ser: CFTypeRef? = serialNumberAsCFString?.takeUnretainedValue()
        if let result = ser as? String {
            return result
        }
        return nil
    }

}

extension Config {
    func configFileName() -> String {
        guard let uuid = getHardwareUUID(), let number = getHardwareSerialNumber() else {
            return ""
        }
        if let user = LCApplication.default.currentUser {
            return md5(user.username?.stringValue ?? uuid + number)
        }else {
            return md5(uuid + number)
        }
    }
}
