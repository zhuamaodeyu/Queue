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

    private let shell:String
    private let path:String
    private let logname: String
    private let user: String

    private init() {
        self.shell = ProcessInfo.processInfo.environment["SHELL"] ?? ""
        self.path =  ProcessInfo.processInfo.environment["PATH"]  ?? ""
        self.logname = ProcessInfo.processInfo.environment["LOGNAME"] ?? ""
        self.user = ProcessInfo.processInfo.environment["USER"] ?? ""
    }
}


// MARK: - which
extension Command {
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


