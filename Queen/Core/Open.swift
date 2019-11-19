//
//  Open.swift
//  Queen
//
//  Created by 聂子 on 2019/7/14.
//  Copyright © 2019 聂子. All rights reserved.
//

import Foundation
import TKFoundationModule
class Open {
    /// open xcode
    ///
    /// - Parameter path: path
    static func xcode(path: String) {
        if !FileManager.ns.isFile(path: path) {
            return
        }
        guard let open = Command.shared.which(command: "open") else {
            debugPrint("is not found open , please check , system error")
            return
        }
        Process.run(command: open, args: [path])
    }

    /// open vscode
    ///
    /// - Parameter path: path
    static func vscode(path: String) {
        guard let code = Command.shared.which(command: "code") else {
            debugPrint("is not found code , please check , system error")
            return
        }
        Process.run(command: code, args: [path])
    }

    /// open from finder
    ///
    /// - Parameter path: path
    static func finder(dir path: String) {
        guard let open = Command.shared.which(command: "open") else {
            debugPrint("is not found code , please check , system error")
            return
        }
        if !FileManager.ns.dir(path: path) {
            debugPrint("is not open dir, please ")
        }
        Process.run(command: open, args: [path])
    }
}


extension Open {
    /// open Documetation
    ///
    /// - Parameters:
    ///   - name: name
    ///   - url: url
    static func openDocumentation(with name: String, url: String) {
        NotificationCenter.default.post(name: .documentation, object: nil, userInfo: [
            DocumentationAssociatedKey.name: name,
            DocumentationAssociatedKey.url: url
            ])
    }
}

extension Notification.Name {
    static var documentation = Notification.Name.init("documentation")
}



// MARK: - Open Cocoapods
extension Open {
    static func openPodspecReference() {
        NotificationCenter.default.post(name: .openPodspecReference, object: nil, userInfo: [
            DocumentationAssociatedKey.name:"openPodspecReference",
            DocumentationAssociatedKey.url : "https://guides.cocoapods.org/syntax/podspec.html"
            ])
    }
    static func openSearch() {
        NotificationCenter.default.post(name: .openSearch, object: nil, userInfo: [
            DocumentationAssociatedKey.name:"openSearch",
            DocumentationAssociatedKey.url : "https://cocoapods.org/"
            ])
    }
    static func openPod(with name: String) {
        NotificationCenter.default.post(name: .openPodWithName, object: nil, userInfo: [
            DocumentationAssociatedKey.name:"openPodWithName",
            DocumentationAssociatedKey.url : "https://cocoapods.org/pods/\(name)"
            ])
    }
    static func openPodfileReference() {
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
