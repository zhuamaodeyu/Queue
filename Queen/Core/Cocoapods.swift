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
    private var path: String?
    private init() {
        self.path = Command.shared.which(command: "pod")
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


// MARK: - check Podfile
extension Cocoapods {
    func checkPodfileUpdate(last date: Date) -> Bool {
        return false
    }
}

// MARK: - cocoapods
extension Cocoapods {
    public func podInstall() {

    }
    public func podUpdate() {

    }
    public func podSearch() {

    }
}



// MARK: - Open
extension Cocoapods {
    public func openPodspecReference() {
        NotificationCenter.default.post(name: .openPodspecReference, object: nil, userInfo: [
            DocumentationAssociatedKey.name:"openPodspecReference",
            DocumentationAssociatedKey.url : "https://guides.cocoapods.org/syntax/podspec.html"
            ])
    }
    public func openSearch() {
        NotificationCenter.default.post(name: .openSearch, object: nil, userInfo: [
            DocumentationAssociatedKey.name:"openSearch",
            DocumentationAssociatedKey.url : "https://cocoapods.org/"
            ])
    }
    public func openPod(with name: String) {
        NotificationCenter.default.post(name: .openPodWithName, object: nil, userInfo: [
            DocumentationAssociatedKey.name:"openPodWithName",
            DocumentationAssociatedKey.url : "https://cocoapods.org/pods/\(name)"
            ])
    }
    public func openPodfileReference() {
        NotificationCenter.default.post(name: .openPodfileReference, object: nil, userInfo: [
            DocumentationAssociatedKey.name:"openPodfileReference",
            DocumentationAssociatedKey.url : "https://guides.cocoapods.org/syntax/podfile.html"
            ])
    }
}


extension Notification.Name {
    static var openPodspecReference = Notification.Name.init("openPodspecReference")
    static var openSearch = Notification.Name.init("openSearch")
    static var openPodWithName = Notification.Name.init("openPod")
    static var openPodfileReference = Notification.Name.init("openPodfileReference")
}
