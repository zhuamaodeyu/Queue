//
//  Xcode.swift
//  Queen
//
//  Created by 聂子 on 2019/7/14.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa



class Xcode {
    static let shared = Xcode.init()
    private var xcodePath: String?
    private init() {
        self.xcodePath = Command.shared.which(command: "xcodebuild")
    }
}

extension Xcode {

    /// 检测是否安装xcode
    ///
    /// - Returns:
    func check() -> Bool {
        if let p = self.xcodePath {
            return true
        }
        return false
    }

    /// 安装 xcode-select --install
    ///
    /// - Returns: <#return value description#>
    func install() -> Bool {

        return false
    }
}
