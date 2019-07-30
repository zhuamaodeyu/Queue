//
//  Xcode.swift
//  Queen
//
//  Created by 聂子 on 2019/7/14.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa

//http://liumh.com/2015/11/25/ios-auto-archive-ipa/
struct XcodeProject {
    static var xcodeproj:String = "xcodeproj"
    static var xcworkspace:String = "xcworkspace"
}


class Xcode {
    static let shared = Xcode.init()
    private var path: String?
    private init() {
        self.path = Command.shared.which(command: "xcodebuild")
    }
}

extension Xcode {

    /// 检测是否安装xcode
    ///
    /// - Returns:
    func check() -> Bool {
        if let _ = self.path {
            return true
        }
        return false
    }

    /// 安装 xcode-select --install
    ///
    /// - Returns: 
    func install() -> Bool {

        return false
    }
}


// MARK: - xcode build
extension Xcode {
    public func build() {
        guard let _ = self.path else {
            return
        }
    }

    public func archive() {
        guard let _ = self.path else {
            return
        }
        //        xcodebuild archive -workspace 项目名称.xcworkspace
        //        -scheme 项目名称
        //        -configuration 构建配置
        //        -archivePath archive包存储路径
        //        CODE_SIGN_IDENTITY=证书
        //        PROVISIONING_PROFILE=描述文件UUID
    }

    public func list() -> String {
        guard let xb = self.path else {
            return ""
        }
        if let result = Process.run(command: xb, args: ["-list","-json"]), !result.isEmpty {
            return result
        }
        return ""
    }

    public func exportArchive() {
        guard let _ = self.path else {
            return
        }
        //        xcodebuild -exportArchive -archivePath archive文件的地址.xcarchive
        //        -exportPath 导出的文件夹地址
        //        -exportOptionsPlist exprotOptionsPlist.plist
        //        CODE_SIGN_IDENTITY=证书
        //        PROVISIONING_PROFILE=描述文件UUID
    }
}

extension Xcode {

    /// 获取项目名称
    ///
    /// - Parameter path: path
    /// - Returns: project Name
    public func projectName(path: String) -> String? {
        let url = URL.init(fileURLWithPath: path)
        // 当前就是
        if url.pathExtension == XcodeProject.xcodeproj || url.pathExtension == XcodeProject.xcworkspace {
            return (url.lastPathComponent as NSString).deletingPathExtension
        }

        if let path = FileManager.ns.exportPath(url: url)?.filter({ (u) -> Bool in
            let pathExtension = u.pathExtension
            return  pathExtension == XcodeProject.xcodeproj || pathExtension == XcodeProject.xcworkspace
        }).first {
            return (path.lastPathComponent as NSString).deletingPathExtension
        }
        return nil
    }
}

extension Xcode {

    /// open Xcode project
    ///
    /// - Parameter completaion: completaion  url
    public static func selectXcodeProj(_ completaion:@escaping (URL?) -> Void) {
        let openPanel = NSOpenPanel.init()
        openPanel.allowsMultipleSelection = false
        openPanel.allowedFileTypes = [XcodeProject.xcodeproj, XcodeProject.xcworkspace]
        openPanel.begin { (response) in
            guard response == NSApplication.ModalResponse.OK else  {return}
            guard let fileURL = openPanel.url else {completaion(.none); return}
            completaion(fileURL)
        }
    }
}
