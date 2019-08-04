//
//  Command.swift
//  Queen
//
//  Created by 聂子 on 2019/7/14.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa

class Command {
    static let shared = Command.init()

    let shell:String
    let path:String
    let logname: String
    let user: String

    private init() {
        self.shell = ProcessInfo.processInfo.environment["SHELL"] ?? ""
        self.path =  ProcessInfo.processInfo.environment["PATH"]  ?? ""
        self.logname = ProcessInfo.processInfo.environment["LOGNAME"] ?? ""
        self.user = ProcessInfo.processInfo.environment["USER"] ?? ""
    }
}


// MARK: - which
extension Command {

    /// 基础命令
    ///
    /// - Parameter name: 名字
    /// - Returns: path 
    public func which(command name:String) -> String? {
        if self.shell.isEmpty {
            return nil
        }
        if let path = Process.run(command: shell, args: ["-l","-c","which \(name)"])?.trimmingCharacters(in: .whitespacesAndNewlines) {
            return path
        }
        return nil
    }
}


