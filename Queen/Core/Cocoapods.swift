//
//  Cocoapods.swift
//  Queen
//
//  Created by 聂子 on 2019/7/14.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa


private var cocoapodPath = Command.shared.which(command: "pod")


class Cocoapods {
    private(set) var path: String
    init?() {
        if let p = cocoapodPath {
            self.path = p
            return
        }
        return nil
    }

}

extension Cocoapods {
    /// 检测路径是否是一个 cocoapod 项目
    ///
    /// - Parameter path: path
    /// - Returns: default false
    static func check(url path: String) -> Bool {
        

        return false
    }
}
