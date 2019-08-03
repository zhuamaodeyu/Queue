//
//  XcodeActionCoordinator.swift
//  Queen
//
//  Created by 聂子 on 2019/8/3.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa

enum XcodeAtionType {
    case build(path:String)
    case archive(path: String)
    case exportArchive(path: String,exportPath: String)
}

class XcodeActionCoordinator: NSObject {
    
}
//// MARK: - xcode build
//extension Xcode {
//    func build() {
//        guard let _ = path else {
//            return
//        }
//    }
//
//    func archive() {
//        guard let _ = path else {
//            return
//        }
//        //        xcodebuild archive -workspace 项目名称.xcworkspace
//        //        -scheme 项目名称
//        //        -configuration 构建配置
//        //        -archivePath archive包存储路径
//        //        CODE_SIGN_IDENTITY=证书
//        //        PROVISIONING_PROFILE=描述文件UUID
//    }
//
//
//    func exportArchive() {
//        guard let _ = path else {
//            return
//        }
//        //        xcodebuild -exportArchive -archivePath archive文件的地址.xcarchive
//        //        -exportPath 导出的文件夹地址
//        //        -exportOptionsPlist exprotOptionsPlist.plist
//        //        CODE_SIGN_IDENTITY=证书
//        //        PROVISIONING_PROFILE=描述文件UUID
//    }
//}
