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

    public static func xcode(path: String) {
        if !FileManager.ns.isFile(path: path) {
            return
        }
        guard let _ = Command.shared.which(command: "open") else {
            debugPrint("is not found open , please check , system error")
            return
        }

    }
    public static func vscode(path: String) {
        guard let code = Command.shared.which(command: "code") else {
            debugPrint("is not found code , please check , system error")
            return
        }
        Process.run(command: code, args: [path])
    }

    public static func finder(dir path: String) {
        guard let open = Command.shared.which(command: "open") else {
            debugPrint("is not found code , please check , system error")
            return
        }
        if !FileManager.ns.isDir(path: path) {
            debugPrint("is not open dir, please ")
        }
        Process.run(command: open, args: [path])
    }
}


extension Open {
    public static func openDocumentation(with name: String, url: String) {
        NotificationCenter.default.post(name: .documentation, object: nil, userInfo: [
            DocumentationAssociatedKey.name: name,
            DocumentationAssociatedKey.url: url
            ])
    }
}

extension Notification.Name {
    static var documentation = Notification.Name.init("documentation")
}
