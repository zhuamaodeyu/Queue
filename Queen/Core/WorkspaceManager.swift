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
        let url = URL.init(fileURLWithPath: path)
        if url.pathExtension == DocumentAssociatedKeys.qworkspace {
            return true
        }
        // 不存在
        if !FileManager.ns.isExit(path: path) {
            return false
        }

        // 不是文件夹
        if !FileManager.ns.isDir(path: path) {
            return false
        }

        // 文件是否存在
        if FileManager.ns.exportPath(url: url)?.filter({ (url) -> Bool in
            url.pathExtension == DocumentAssociatedKeys.qworkspace
        }).count ?? 0 > 0 {
            return true
        }
        return false
    }

    static func initizale(path: String) -> String {
        if WorkspaceManager.check(with: path) {
            return ""
        }
        guard let projectName = Xcode.shared.projectName(path: path) else {
            return ""
        }
        if FileManager.ns.createFolder(name: "\(projectName).\(DocumentAssociatedKeys.qworkspace)", baseUrl: URL.init(fileURLWithPath: path)) {
            return ""
        }
        return ""
    }
}

