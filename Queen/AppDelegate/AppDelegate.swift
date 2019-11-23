//
//  AppDelegate.swift
//  Queen
//
//  Created by 聂子 on 2019/7/5.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa
import LeanCloud
@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    override init() {
        AppDelegate.initialSettings()

        _ = DocumentController.shared
        AppDelegate.initLeanCloud()
        super.init()
    }

}

extension AppDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        registerNotification()
    }

    func applicationWillTerminate(_ aNotification: Notification) {

    }
    func applicationWillBecomeActive(_ notification: Notification) {
        if NSApp.orderedDocuments.count == 0 {
//            showWelcomeWindow()
        }
    }

    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        if !flag {
            showWelcomeWindow()
        }
        return true
    }
}

extension AppDelegate {
    private func showWelcomeWindow() {
        guard let welcomeWindowController = NSStoryboard.windowController(name: "WelcomeWindowController", storyboard: "Welcome") as? WelcomeWindowController else {
            return
        }
        welcomeWindowController.window?.center()
        welcomeWindowController.showWindow(nil)
    }
}

