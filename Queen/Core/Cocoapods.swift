//
//  Cocoapods.swift
//  Queen
//
//  Created by 聂子 on 2019/7/14.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa


class Cocoapods {
    static let shared = Cocoapods.init()
    private var podPath: String?
    private init() {
        self.podPath = Command.shared.which(command: "pod")
    }
}

extension Cocoapods {

    /// 检测路径是否是一个 cocoapod 项目
    ///
    /// - Parameter path: path
    /// - Returns: default false
    func check(url path: String) -> Bool {
        

        return false
    }


    /// 检测是否安装cocoapod
    ///
    /// - Returns: default false
    func check() -> Bool {

        return false
    }


    /// 安装cocoapods
    ///
    /// - Returns: default false 
    func install() -> Bool {

        return false 
    }
}

