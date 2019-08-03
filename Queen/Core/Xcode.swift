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


private var path: String? = Command.shared.which(command: "xcodebuild")
class Xcode {
    private var xcodePath: String
    init?() {
        if let p = path {
            xcodePath = p
            return
        }
        return nil
    }
}

extension Xcode{
    func list() -> String {
        guard let xb = path else {
            return ""
        }
        if let result = Process.run(command: xb, args: ["-list","-json"]), !result.isEmpty {
            return result
        }
        return ""
    }
}

extension Xcode {

    /// 获取项目名称
    ///
    /// - Parameter path: path
    /// - Returns: project Name
    static func projectName(path: String) -> String? {
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
    static func selectXcodeProj(_ completaion:@escaping (URL?) -> Void) {
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
