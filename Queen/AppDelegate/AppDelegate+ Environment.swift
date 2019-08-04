//
//  AppDelegate+ Environment.swift
//  Queen
//
//  Created by 聂子 on 2019/8/4.
//  Copyright © 2019 聂子. All rights reserved.
//

import Foundation

extension AppDelegate {
    private struct EnvironmentAssociatedKeys {
        static var environment = "EnvironmentAssociatedKeys_environment"
    }
    var environment:Environment? {
        set {
            objc_setAssociatedObject(self, &EnvironmentAssociatedKeys.environment, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }

        get {
            return objc_getAssociatedObject(self, &EnvironmentAssociatedKeys.environment) as? Environment
        }
    }
    // 设置环境变量
    func cacheEnvironment() {
        if Path.environment.isEmpty {
            debugPrint("environment script path is empty")
            return
        }
        self.environment = Environment.init()

        Process.syncRun(command: Command.shared.shell, args: [Path.cacheEnvironment]) { (process, output, err) in
            if let result = output {
                let keyValues = result.split(separator: "\n").map({ (s) -> [Substring] in
                    return s.split(separator: "=")
                })
                for keyvalue in keyValues {
                    let value = keyvalue.first == keyvalue.last ? "" : String(keyvalue.last ?? "")
                    switch Environment.EnvType.init(rawValue:String(keyvalue.first ?? "")) ?? .none {
                    case .RUBYOPT:
                        self.environment?.RUBYOPT = value
                        break
                    case .RUBYLIB:
                        self.environment?.RUBYLIB = value
                        break
                    case .PATH:
                        self.environment?.PATH = value
                        break
                    case .GEM_HOME:
                        self.environment?.GEM_HOME = value
                        break
                    case .GEM_PATH:
                        self.environment?.GEM_PATH = value
                        break
                    case .GEM_CACHE:
                        self.environment?.GEM_CACHE = value
                        break
                    default:
                        break
                    }
                }
            }
        }
    }

    // 清理环境变量
    func reductionEnvironment() {

    }

    func setEnvironment() {

    }

}
