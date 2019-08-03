//
//  AppDelegate+Document.swift
//  Queen
//
//  Created by 聂子 on 2019/8/3.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa



extension AppDelegate {
    // 系统调用此方法
    func application(_ sender: NSApplication, openFiles filenames: [String]) {
        let dispatchGroup = DispatchGroup.init()

        for filename in filenames {
            guard self.application(sender, openFile: filename) else {
                continue
            }
            let url = URL.init(fileURLWithPath: filename)
            dispatchGroup.enter()
            DocumentController.shared.openDocument(withContentsOf: url, display: true) { (document, documentWasAlreadyOpen, error) in
                defer {
                    dispatchGroup.leave()
                }
                if let error = error {
                    NSApp.presentError(error)

                    let cancelled = (error as? CocoaError)?.code == .userCancelled
                    NSApp.reply(toOpenOrPrint: cancelled ? .cancel : .failure)
                }
            }
            dispatchGroup.notify(queue: .main) {

            }
        }
    }
    func application(_ sender: NSApplication, openFile filename: String) -> Bool {
        // 判断是否支持当前的文件格式
        let url = URL.init(fileURLWithPath: filename)
        guard DocumentType.default.extensions.contains(url.pathExtension)  else {
            return false
        }
        return true
    }
    func applicationShouldOpenUntitledFile(_ sender: NSApplication) -> Bool {
        return false
    }

}


