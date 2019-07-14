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
    //    http://liumh.com/2015/11/25/ios-auto-archive-ipa/
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

    public func list() {
        guard let _ = self.path else {
            return
        }
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
