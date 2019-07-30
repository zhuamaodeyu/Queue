//
//  Carthage.swift
//  Queen
//
//  Created by 聂子 on 2019/7/14.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa


class Carthage {
    static let shared = Carthage.init()
    private var path: String?
    private init() {
        self.path = Command.shared.which(command: "carthage")
    }
}


// MARK: - check
extension Carthage {
    /// 检测是否安装 Carthage
    ///
    /// - Returns:
    func check() -> Bool {
        if let _ = self.path {
            return true
        }
        return false
    }

    /// 安装
    ///
    /// - Returns:
    func install() {

    }
}

extension Carthage {

    /// 检查当前目录是否是一个 Carthage 项目
    ///
    /// - Parameter path: path
    /// - Returns: default false 
    func check(path: String) -> Bool {
 
        return false
    }
}
