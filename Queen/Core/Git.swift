//
//  Git.swift
//  Queen
//
//  Created by 聂子 on 2019/7/14.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa

class Git {
    static let shared = Git.init()
    private var gitPath: String?
    private init() {
        self.gitPath = Command.shared.which(command: "git")
    }
    
}


extension Git {

    /// 检测当前路径是否是一个 git 仓库
    ///
    /// - Parameter path: path
    /// - Returns: defualt false
    func check(url path: String) -> Bool {
        guard let gp = self.gitPath else {
            return false
        }
        let result = Process.run(command: gp, args: ["ls-remote","--exit-code",path])
        if let _ =  result {

        }
        return false
    }
}

