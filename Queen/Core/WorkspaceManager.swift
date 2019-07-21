//
//  WorkspaceManager.swift
//  Queen
//
//  Created by 聂子 on 2019/7/16.
//  Copyright © 2019 聂子. All rights reserved.
//

import Foundation

class WorkspaceManager {

    /// 检测当前选中目录是否是一个工作空间
    ///
    /// - Parameter path: path
    static func check(with path: String) -> Bool {
        // 不存在
        if !FileManager.ns.isExit(path: path) {
            return false
        }
        // 不是文件夹
        if !FileManager.ns.isDir(path: path) {
            return false
        }

        let allPath = FileManager.ns.exportPath(url: URL.init(fileURLWithPath: path))

        if allPath?.filter({ (u) -> Bool in
            u.pathExtension == XcodeProject.xcworkspace || u.pathExtension == XcodeProject.xcodeproj
        }).count ?? 0 <= 0 {
            return false
        }

        if allPath?.filter({ (u) -> Bool in
            u.lastPathComponent == "Podfile"
        }).count ?? 0 <= 0 {
            return false
        }

        return true
    }

    @discardableResult
    static func initizale(path: String) -> URL? {
        if !WorkspaceManager.check(with: path) {
            return nil
        }
        let pathUrl = URL.init(fileURLWithPath: path)
        if pathUrl.pathExtension == DocumentAssociatedKeys.qworkspace {
            return pathUrl
        }


        if let url = FileManager.ns.exportPath(url: pathUrl)?.filter({ (u) -> Bool in
            u.pathExtension == DocumentAssociatedKeys.qworkspace
        }).first {
            return url
        }

        guard let projectName = Xcode.shared.projectName(path: path) else {
            return nil
        }

        let baseUrl =  pathUrl.appendingPathComponent("\(projectName).\(DocumentAssociatedKeys.qworkspace)", isDirectory: true)

        if FileManager.ns.createFolder(name: nil, baseUrl: baseUrl) {
            return baseUrl
        }
        return nil
    }
}


extension WorkspaceManager {
   static func insert(workspcace model: WelcomeWorkspaceModel) {
        if Config.shared.workspaceList.filter({ (m) -> Bool in
            m.address.stringValue == model.address.stringValue
        }).count > 0 {
            return
        }
        Config.shared.workspaceList.insert(model, at: 0)
    }
}
