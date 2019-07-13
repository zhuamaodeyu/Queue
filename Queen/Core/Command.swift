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
        if let path = Process.run(command: shell, args: ["-l","-c","which \(name)"]) {
            return path
        }
        return nil
    }
}


// MARK: - open
extension Command {
    public func xcodeOpen() {

    }
    public func vscodeOpen() {

    }
    public func folderOpen() {

    }
}


// MARK: - cocoapods
extension Command {
    public func podInstall() {

    }
    public func podUpdate() {

    }
    public func podSearch() {

    }
}


// MARK: - xcode build
extension Command {
    //    http://liumh.com/2015/11/25/ios-auto-archive-ipa/
    public func xcodeBuild() {
        guard let path = which(command: "xcodebuild")?.trimmingCharacters(in: .newlines), !path.isEmpty else {
            return
        }
    }

    public func xcodeArchive() {
        guard let path = which(command: "xcodebuild")?.trimmingCharacters(in: .newlines), !path.isEmpty else {
            return
        }
        //        xcodebuild archive -workspace 项目名称.xcworkspace
        //        -scheme 项目名称
        //        -configuration 构建配置
        //        -archivePath archive包存储路径
        //        CODE_SIGN_IDENTITY=证书
        //        PROVISIONING_PROFILE=描述文件UUID
    }

    public func xcodeList() {
        guard let path = which(command: "xcodebuild")?.trimmingCharacters(in: .newlines), !path.isEmpty else {
            return
        }
    }

    public func xcodeExportArchive() {
        guard let path = which(command: "xcodebuild")?.trimmingCharacters(in: .newlines), !path.isEmpty else {
            return
        }
        //        xcodebuild -exportArchive -archivePath archive文件的地址.xcarchive
        //        -exportPath 导出的文件夹地址
        //        -exportOptionsPlist exprotOptionsPlist.plist
        //        CODE_SIGN_IDENTITY=证书
        //        PROVISIONING_PROFILE=描述文件UUID
    }
}
