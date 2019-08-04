//
//  Git.swift
//  Queen
//
//  Created by 聂子 on 2019/7/14.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa

class Git {}

extension Git {

    /// 检测当前路径是否是一个 git 仓库
    ///
    /// - Parameter path: path
    /// - Returns: defualt false
    static func check(url path: String) -> Bool {
        if path.isEmpty || Path.git.isEmpty {
            debugPrint("path is empty or git command path is empty")
            return false
        }
        if let result = Process.run(command: Path.git, args: ["ls-remote","--exit-code",path]), !result.isEmpty {
            return true
        }
        return false
    }
}
